#!/usr/bin/env python3
"""Behavior checks for the reviewed beta 0.3 generated helper's run(root, apply).

The fixture and helper are supplied privately, not installed by this script.
"""

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile
import unittest

sys.dont_write_bytecode = True
STATE = None
SOURCE = None
EXPECTED_DIGEST = None
EXPECTED_VERSION = None


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def snapshot(root):
    return {str(path.relative_to(root)): ("link", str(path.readlink())) if path.is_symlink()
            else ("file", digest(path)) for path in root.rglob("*")
            if (path.is_file() or path.is_symlink()) and ".git" not in path.parts}


class ReleaseFixtureChecks(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="substrate-review-")
        self.outer = Path(self.temp.name)
        self.root = self.outer / "project"
        shutil.copytree(SOURCE, self.root, ignore=shutil.ignore_patterns(".git", "__pycache__"))
        spec = importlib.util.spec_from_file_location(
            "reviewed_copy_undo", self.root / ".agentic-substrate/local/undo.py")
        self.undo = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.undo)

    def tearDown(self):
        self.temp.cleanup()

    def receipt(self):
        return json.loads((self.root / ".agentic-substrate/installation.json").read_text())

    def set_receipt(self, receipt):
        (self.root / ".agentic-substrate/installation.json").write_text(json.dumps(receipt))

    def rejection(self):
        before = snapshot(self.root)
        with self.assertRaises(ValueError):
            self.undo.run(self.root, True)
        self.assertEqual(before, snapshot(self.root))

    def test_source_owned_files_exact_original_backups(self):
        receipt = self.receipt()
        self.assertEqual(EXPECTED_DIGEST, receipt["source"]["sha256"])
        self.assertEqual(EXPECTED_DIGEST, digest(self.root / "INSTALL.md"))
        self.assertEqual(EXPECTED_VERSION, receipt["active_harness"]["version"])
        self.assertEqual("disabled", receipt["memory_mode"])
        for record in receipt["files"]:
            self.assertEqual(record["installed_sha256"], digest(self.root / record["path"]))
            if record["existed"]:
                backup = self.root / record["backup"]
                self.assertEqual(record["before_sha256"], digest(backup))
                self.assertEqual(STATE["originals"][record["path"]], backup.read_text())
                if os.name != "nt":
                    self.assertEqual(0o600, backup.stat().st_mode & 0o777)
        self.assertEqual(STATE["originals"]["AGENTS.md"], (self.root / "AGENTS.md").read_text())
        self.assertFalse((self.root / ".agentic-substrate/knowledge").exists())

    def test_preview_is_readonly(self):
        before = snapshot(self.root)
        result = self.undo.run(self.root)
        self.assertEqual(2, len(result["changes"]))
        self.assertEqual(before, snapshot(self.root))

    def test_untouched_restore_and_repeat(self):
        self.undo.run(self.root, True)
        self.assertEqual(STATE["originals"]["AGENTS.override.md"],
                         (self.root / "AGENTS.override.md").read_text())
        self.assertFalse((self.root / ".agentic-substrate/CORE.md").exists())
        self.assertEqual([], self.undo.run(self.root, True)["changes"])

    def test_later_user_edits_and_knowledge_survive(self):
        extra = "\nPreserve this later edit.\n"
        for name in ("AGENTS.override.md", ".gitignore"):
            path = self.root / name
            path.write_text(path.read_text() + extra)
        note = self.root / ".agentic-substrate/knowledge/note.md"
        note.parent.mkdir()
        note.write_text("User-created knowledge.\n")
        self.undo.run(self.root, True)
        self.assertEqual(STATE["originals"]["AGENTS.override.md"] + extra,
                         (self.root / "AGENTS.override.md").read_text())
        self.assertTrue((self.root / ".gitignore").read_text().endswith(extra))
        self.assertIn("/.agentic-substrate/local/", (self.root / ".gitignore").read_text())
        self.assertEqual("User-created knowledge.\n", note.read_text())

    def test_modified_managed_block_rejected(self):
        path = self.root / "AGENTS.override.md"
        marker = "<!-- agentic-substrate:start -->"
        text = path.read_text()
        self.assertIn(marker, text)
        path.write_text(text.replace(marker, marker + "\nUser changed this", 1))
        self.rejection()

    def test_modified_core_rejected(self):
        path = self.root / ".agentic-substrate/CORE.md"
        path.write_text(path.read_text() + "User changed core.\n")
        self.rejection()

    def test_corrupt_original_backup_rejected(self):
        record = next(record for record in self.receipt()["files"] if record["existed"])
        (self.root / record["backup"]).write_text("damaged")
        self.rejection()

    def test_receipt_path_escape_rejected(self):
        outside = self.outer / "outside"
        outside.write_text("Outside unchanged")
        receipt = self.receipt()
        receipt["files"][0]["path"] = "../outside"
        self.set_receipt(receipt)
        self.rejection()
        self.assertEqual("Outside unchanged", outside.read_text())

    def test_symlink_escape_rejected(self):
        outside = self.outer / "outside"
        outside.write_text("Outside unchanged")
        path = self.root / ".agentic-substrate/CORE.md"
        path.unlink()
        try:
            path.symlink_to(outside)
        except (NotImplementedError, OSError) as error:
            self.skipTest(f"Host cannot create test symlink: {error}")
        self.rejection()
        self.assertEqual("Outside unchanged", outside.read_text())

    def test_unknown_schema_rejected(self):
        receipt = self.receipt()
        receipt["schema_version"] = 987
        self.set_receipt(receipt)
        self.rejection()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fixture-metadata", required=True, type=Path,
                        help="Private JSON containing project path and originals UTF-8 text map")
    parser.add_argument("--expected-source-sha256", required=True)
    parser.add_argument("--expected-cli-version", required=True)
    parser.add_argument("--trust-reviewed-undo", action="store_true")
    args = parser.parse_args()
    if not args.trust_reviewed_undo:
        parser.error("Review the fixture's undo.py before using --trust-reviewed-undo")
    STATE = json.loads(args.fixture_metadata.read_text())
    SOURCE = Path(STATE["project"]).resolve()
    EXPECTED_DIGEST = args.expected_source_sha256
    EXPECTED_VERSION = args.expected_cli_version
    before = snapshot(SOURCE)
    print("Generated beta-helper checks on copies; not a live-model uninstall.", flush=True)
    result = unittest.TextTestRunner(verbosity=2).run(
        unittest.defaultTestLoader.loadTestsFromTestCase(ReleaseFixtureChecks))
    if before != snapshot(SOURCE):
        raise RuntimeError("Original fixture changed during verifier run")
    print("Original live fixture unchanged.")
    raise SystemExit(not result.wasSuccessful())
