#!/usr/bin/env python3
"""Optional behavior checks for a reviewed Codex-generated installation fixture.

This is a test of a particular generated rollback(root, apply) implementation,
not an adapter bundled with Agentic Substrate. It executes the supplied helper.
"""

import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import sys
import tempfile
import unittest

sys.dont_write_bytecode = True
FIX = None
SOURCE = None
UNDO = None
EXPECTED_CLI_VERSION = None


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def snapshot(root):
    return {str(path.relative_to(root)): digest(path)
            for path in root.rglob("*") if path.is_file()}


class InstallationContract(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="substrate-independent-")
        self.outer = Path(self.temp.name)
        self.work = self.outer / "project"
        shutil.copytree(SOURCE, self.work, ignore=shutil.ignore_patterns(".git", "__pycache__"))

    def tearDown(self):
        self.temp.cleanup()

    def test_receipt_matches_files_and_original_backups(self):
        receipt = json.loads((self.work / ".agentic-substrate/installation.json").read_text())
        self.assertEqual(EXPECTED_CLI_VERSION, receipt["adapter"]["cli_version"])
        for record in receipt["owned_files"]:
            self.assertEqual(record["installed_sha256"], digest(self.work / record["path"]))
            if record["existed"]:
                self.assertEqual(record["original_sha256"], digest(self.work / record["backup_path"]))
                self.assertEqual(FIX["original"][record["path"]],
                                 (self.work / record["backup_path"]).read_text())

    def test_existing_instructions_preserved_without_duplicates(self):
        content = (self.work / FIX["active"]).read_text()
        self.assertIn(FIX["original"][FIX["active"]], content)
        self.assertEqual(1, content.count("<!-- agentic-substrate:start -->"))
        self.assertEqual(FIX["original"][FIX["shadow"]], (self.work / FIX["shadow"]).read_text())

    def test_preview_is_read_only(self):
        before = snapshot(self.work)
        self.assertTrue(UNDO.rollback(self.work, False))
        self.assertEqual(before, snapshot(self.work))

    def test_untouched_rollback_restores_original_and_repeats_safely(self):
        UNDO.rollback(self.work, True)
        self.assertEqual(FIX["original"][FIX["active"]], (self.work / FIX["active"]).read_text())
        self.assertFalse((self.work / ".agentic-substrate/CORE.md").exists())
        self.assertEqual([], UNDO.rollback(self.work, False))

    def test_later_user_edits_and_knowledge_survive(self):
        extra = "\n## User addition\nRetain this exact sentence.\n"
        with (self.work / FIX["active"]).open("a") as handle:
            handle.write(extra)
        note = self.work / ".agentic-substrate/knowledge/user-note.md"
        note.parent.mkdir(parents=True)
        note.write_text("User knowledge must survive.\n")
        UNDO.rollback(self.work, True)
        self.assertEqual(FIX["original"][FIX["active"]] + extra,
                         (self.work / FIX["active"]).read_text())
        self.assertEqual("User knowledge must survive.\n", note.read_text())
        self.assertIn("/.agentic-substrate/local/", (self.work / ".gitignore").read_text())
        self.assertIn(FIX["original"][".gitignore"], (self.work / ".gitignore").read_text())

    def test_managed_block_conflict_preserves_everything(self):
        path = self.work / FIX["active"]
        text = path.read_text()
        marker = "<!-- agentic-substrate:start -->"
        self.assertIn(marker, text)
        path.write_text(text.replace(marker, marker + "\nUSER CHANGED THIS BLOCK", 1))
        before = snapshot(self.work)
        with self.assertRaises(RuntimeError):
            UNDO.rollback(self.work, True)
        self.assertEqual(before, snapshot(self.work))

    def test_modified_core_is_not_deleted(self):
        path = self.work / ".agentic-substrate/CORE.md"
        path.write_text(path.read_text() + "\nUser-added core guidance.\n")
        before = snapshot(self.work)
        with self.assertRaises(RuntimeError):
            UNDO.rollback(self.work, True)
        self.assertEqual(before, snapshot(self.work))

    def test_corrupt_backup_blocks_restore(self):
        receipt = json.loads((self.work / ".agentic-substrate/installation.json").read_text())
        record = next(record for record in receipt["owned_files"] if record["existed"])
        (self.work / record["backup_path"]).write_text("damaged backup")
        before = snapshot(self.work)
        with self.assertRaises(RuntimeError):
            UNDO.rollback(self.work, True)
        self.assertEqual(before, snapshot(self.work))

    def test_path_escape_is_rejected(self):
        victim = self.outer / "outside.txt"
        victim.write_text("outside must survive")
        path = self.work / ".agentic-substrate/installation.json"
        receipt = json.loads(path.read_text())
        receipt["owned_files"][0]["path"] = "../outside.txt"
        path.write_text(json.dumps(receipt))
        before = snapshot(self.work)
        with self.assertRaises(RuntimeError):
            UNDO.rollback(self.work, True)
        self.assertEqual("outside must survive", victim.read_text())
        self.assertEqual(before, snapshot(self.work))

    def test_symlink_escape_is_rejected(self):
        victim = self.outer / "outside.txt"
        victim.write_text("outside must survive")
        path = self.work / FIX["active"]
        path.unlink()
        try:
            path.symlink_to(victim)
        except (NotImplementedError, OSError) as error:
            self.skipTest(f"Host cannot create test symlink: {error}")
        with self.assertRaises(RuntimeError):
            UNDO.rollback(self.work, True)
        self.assertEqual("outside must survive", victim.read_text())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fixture-metadata", required=True, type=Path,
                        help="Private JSON with path, active, shadow, original UTF-8 texts")
    parser.add_argument("--expected-cli-version", required=True)
    parser.add_argument("--trust-reviewed-undo", action="store_true",
                        help="Confirm supplied generated Python helper has been reviewed")
    args = parser.parse_args()
    if not args.trust_reviewed_undo:
        parser.error("Review the fixture's undo.py before using --trust-reviewed-undo")
    FIX = json.loads(args.fixture_metadata.read_text())
    if "fixtures" in FIX:  # Accept the original private validation runner's envelope.
        FIX = FIX["fixtures"]["codex"]
    SOURCE = Path(FIX["path"]).resolve()
    EXPECTED_CLI_VERSION = args.expected_cli_version
    helper = SOURCE / ".agentic-substrate/local/undo.py"
    if not helper.is_file():
        parser.error("Fixture has no .agentic-substrate/local/undo.py")
    spec = importlib.util.spec_from_file_location("reviewed_fixture_undo", helper)
    UNDO = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(UNDO)
    print("Generated-helper behavior checks on copies; not a live-model uninstall.", flush=True)
    unittest.main(argv=[sys.argv[0]], verbosity=2)
