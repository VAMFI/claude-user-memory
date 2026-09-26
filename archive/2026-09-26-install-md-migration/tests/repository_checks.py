#!/usr/bin/env python3
"""Offline repository checks. These do not prove an LLM follows INSTALL.md."""

import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import re
import subprocess
import sys
import unittest
from urllib.parse import unquote, urlsplit

sys.dont_write_bytecode = True
MIGRATION = Path("archive/2026-09-26-install-md-migration")
BASELINE = "f1c19fcf8d930c2e117ad6e4aeb89cb3fd895ab4"
ROOT = Path(__file__).resolve().parents[3]


def git(*args):
    return subprocess.check_output(["git", "-C", str(ROOT), *args])


def safe_path(value):
    path = PurePosixPath(value)
    if not value or path.is_absolute() or ".." in path.parts or "\\" in value:
        raise ValueError(f"Unsafe repository-relative path: {value!r}")
    return path


def file_bytes(path):
    return os.fsencode(os.readlink(path)) if path.is_symlink() else path.read_bytes()


def tracked_baseline():
    rows = git("ls-tree", "-r", "-z", BASELINE).split(b"\0")
    entries = {}
    for row in filter(None, rows):
        metadata, name = row.split(b"\t", 1)
        mode, kind, oid = metadata.decode().split()
        if kind != "blob":
            raise ValueError("Submodules require explicit preservation checks")
        entries[name.decode()] = (mode, oid)
    return entries


def without_fences(text):
    # The active docs use fenced code, whose sample paths are not links.
    return re.sub(r"(?ms)^\s*(`{3,}|~{3,})[^\n]*\n.*?^\s*\1\s*$", "", text)


def heading_ids(text):
    found = set(re.findall(r'<a\s+(?:name|id)=["\']([^"\']+)', text))
    counts = {}
    for title in re.findall(r"(?m)^#{1,6}\s+(.+?)(?:\s+#+)?$", without_fences(text)):
        title = re.sub(r"\[([^]]+)\]\([^)]*\)", r"\1", title)
        title = re.sub(r"<[^>]+>", "", title)
        slug = re.sub(r"[^\w\- ]", "", title.lower()).replace(" ", "-")
        count = counts.get(slug, 0)
        counts[slug] = count + 1
        found.add(f"{slug}-{count}" if count else slug)
    return found


def local_markdown_links(path):
    text = without_fences(path.read_text(encoding="utf-8"))
    # Inline links/images and reference definitions; remote URLs are never fetched.
    values = re.findall(r"!?\[[^]\n]*\]\((<[^>]+>|[^\s)]+)(?:\s+[^)]*)?\)", text)
    values += re.findall(r"(?m)^\s{0,3}\[[^]]+\]:\s*(<[^>]+>|\S+)", text)
    for value in values:
        value = value.strip("<>")
        parsed = urlsplit(value)
        if parsed.scheme or parsed.netloc:
            continue
        target = (path.parent / unquote(parsed.path)).resolve() if parsed.path else path
        yield value, target, unquote(parsed.fragment)


class RepositoryChecks(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.manifest = json.loads((ROOT / MIGRATION / "baseline-manifest.json").read_text())
        cls.files = cls.manifest["files"]

    def test_root_has_only_public_entrypoints_and_archive(self):
        self.assertEqual({"INSTALL.md", "README.md", "archive"},
                         {p.name for p in ROOT.iterdir() if p.name != ".git"})
        self.assertTrue((ROOT / "INSTALL.md").is_file())
        self.assertTrue((ROOT / "README.md").is_file())
        self.assertTrue((ROOT / "archive").is_dir())

    def test_manifest_is_complete_against_original_git_tree(self):
        self.assertEqual(1, self.manifest["schema_version"])
        self.assertEqual(BASELINE, self.manifest["baseline_commit"])
        original = tracked_baseline()
        paths = [f["original_path"] for f in self.files]
        self.assertEqual(len(paths), len(set(paths)), "Duplicate source records")
        self.assertEqual(set(original), set(paths))
        for record in self.files:
            with self.subTest(path=record["original_path"]):
                self.assertEqual(original[record["original_path"]],
                                 (record["mode"], record["git_blob_id"]))

    def test_archived_bytes_git_blob_ids_and_modes(self):
        for record in self.files:
            with self.subTest(path=record["original_path"]):
                original = safe_path(record["original_path"])
                archived = safe_path(record["archive_path"])
                self.assertEqual((MIGRATION / "legacy" / original).as_posix(), str(archived))
                path = ROOT / archived
                self.assertIn(ROOT, path.parent.resolve().parents,
                              "Archive parent escapes repository through a symlink")
                data = file_bytes(path)
                self.assertEqual(record["sha256"], hashlib.sha256(data).hexdigest())
                # A blob's identity includes Git's type/length header, not just contents.
                blob = b"blob " + str(len(data)).encode() + b"\0" + data
                self.assertEqual(record["git_blob_id"], hashlib.sha1(blob).hexdigest())
                if record["mode"] == "120000":
                    self.assertTrue(path.is_symlink())
                else:
                    self.assertFalse(path.is_symlink())
                    self.assertIn(record["mode"], {"100644", "100755"})
                    if os.name != "nt":
                        self.assertEqual(record["mode"] == "100755",
                                         bool(path.stat().st_mode & 0o111))

    def test_no_missing_or_added_legacy_files(self):
        expected = {f["archive_path"] for f in self.files}
        actual = {p.relative_to(ROOT).as_posix()
                  for p in (ROOT / MIGRATION / "legacy").rglob("*")
                  if p.is_file() or p.is_symlink()}
        self.assertEqual(expected, actual)

    def test_active_markdown_local_links_and_anchors(self):
        legacy = ROOT / MIGRATION / "legacy"
        docs = [ROOT / "README.md", ROOT / "INSTALL.md"]
        docs += [p for p in (ROOT / "archive").rglob("*.md") if legacy not in p.parents]
        for doc in docs:
            for value, target, fragment in local_markdown_links(doc):
                with self.subTest(doc=doc.relative_to(ROOT), link=value):
                    self.assertTrue(target == ROOT or ROOT in target.parents,
                                    "Active documentation links outside checkout")
                    self.assertTrue(target.exists(), f"Missing target: {value}")
                    if fragment and target.suffix.lower() == ".md":
                        self.assertIn(fragment, heading_ids(target.read_text(encoding="utf-8")))

    def test_no_machine_specific_absolute_links_in_active_docs(self):
        legacy = ROOT / MIGRATION / "legacy"
        docs = [ROOT / "README.md", ROOT / "INSTALL.md"]
        docs += [p for p in (ROOT / "archive").rglob("*.md") if legacy not in p.parents]
        for doc in docs:
            text = doc.read_text(encoding="utf-8")
            self.assertNotRegex(text, r"(?:/Users/|/home/)[a-zA-Z0-9_.-]+/",
                                f"Machine-specific path in {doc.relative_to(ROOT)}")


class CheckerRegressionTests(unittest.TestCase):
    def test_rejects_archive_traversal(self):
        for candidate in ("../outside", "/absolute", "a/../../outside", "a\\outside", ""):
            with self.subTest(path=candidate), self.assertRaises(ValueError):
                safe_path(candidate)

    def test_heading_anchor_generation_ignores_code_examples(self):
        text = "# Hello, world!\n## Hello, world!\n```md\n# Not a heading\n```\n"
        self.assertEqual({"hello-world", "hello-world-1"}, heading_ids(text))


class StagedArchiveCheck(unittest.TestCase):
    def test_staged_archive_contains_every_original_blob_and_mode(self):
        manifest = json.loads((ROOT / MIGRATION / "baseline-manifest.json").read_text())
        expected = {record["archive_path"]: (record["mode"], record["git_blob_id"])
                    for record in manifest["files"]}
        actual = {}
        prefix = (MIGRATION / "legacy").as_posix() + "/"
        for row in filter(None, git("ls-files", "--stage", "-z").split(b"\0")):
            metadata, raw_path = row.split(b"\t", 1)
            path = raw_path.decode()
            if path.startswith(prefix):
                mode, oid, stage = metadata.decode().split()
                self.assertEqual("0", stage, "Unmerged index entry")
                actual[path] = (mode, oid)
        self.assertEqual(expected, actual,
                         "Stage every legacy file, including paths ignored by archived rules")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=ROOT)
    parser.add_argument("--check-index", action="store_true",
                        help="Also verify every archived file is correctly staged for commit")
    args = parser.parse_args()
    ROOT = args.repo.resolve()
    print("Structural checks only; no installer/model execution or network requests.", flush=True)
    suite = unittest.TestSuite()
    for case in (CheckerRegressionTests, RepositoryChecks):
        suite.addTests(unittest.defaultTestLoader.loadTestsFromTestCase(case))
    if args.check_index:
        suite.addTests(unittest.defaultTestLoader.loadTestsFromTestCase(StagedArchiveCheck))
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    raise SystemExit(not result.wasSuccessful())
