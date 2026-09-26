#!/usr/bin/env python3
"""Exercise a supplied installed Hermes loader, without model/API requests."""

import argparse
import os
from pathlib import Path
import socket
import subprocess
import sys
import tempfile
import unittest

sys.dont_write_bytecode = True
LOADER = None


class DiscoveryContract(unittest.TestCase):
    """Version-specific behavior observed in Hermes 0.18.2, not a universal API."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="hermes-discovery-")
        self.root = Path(self.temp.name)
        (self.root / ".git").mkdir()

    def tearDown(self):
        self.temp.cleanup()

    def load(self, path=None):
        return LOADER(str(path or self.root), skip_soul=True, context_length=128000)

    def test_agents_fallback_loads(self):
        (self.root / "AGENTS.md").write_text("Portable workflow marker: AGENT-FALLBACK")
        self.assertIn("AGENT-FALLBACK", self.load())

    def test_native_context_shadows_agents(self):
        (self.root / ".hermes.md").write_text("Native workflow: ACTIVE-NATIVE")
        (self.root / "AGENTS.md").write_text("Inactive workflow: HIDDEN-FALLBACK")
        content = self.load()
        self.assertIn("ACTIVE-NATIVE", content)
        self.assertNotIn("HIDDEN-FALLBACK", content)

    def test_native_context_reaches_subdirectory(self):
        (self.root / ".hermes.md").write_text("Inherited workflow: NATIVE-ANCESTOR")
        child = self.root / "src"
        child.mkdir()
        self.assertIn("NATIVE-ANCESTOR", self.load(child))

    def test_agents_fallback_does_not_reach_subdirectory(self):
        (self.root / "AGENTS.md").write_text("Root workflow: ROOT-AGENTS")
        child = self.root / "src"
        child.mkdir()
        self.assertNotIn("ROOT-AGENTS", self.load(child))

    def test_frontmatter_not_injected(self):
        (self.root / ".hermes.md").write_text(
            "---\nfixture: FRONTMATTER-ONLY\n---\n\nBody: VISIBLE-BODY")
        content = self.load()
        self.assertIn("VISIBLE-BODY", content)
        self.assertNotIn("FRONTMATTER-ONLY", content)

    def test_empty_project_has_no_activation(self):
        self.assertEqual("", self.load())


def deny_network(*args, **kwargs):
    raise RuntimeError("Network access is disabled by this offline test")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--hermes-repo", required=True, type=Path,
                        help="Reviewed, installed Hermes checkout; use its Python environment")
    args = parser.parse_args()
    hermes_repo = args.hermes_repo.resolve()
    if not (hermes_repo / "agent/prompt_builder.py").is_file():
        parser.error("--hermes-repo must contain agent/prompt_builder.py")
    # Isolation must precede imports because the runtime caches its home directory.
    with tempfile.TemporaryDirectory(prefix="hermes-offline-state-") as state:
        os.environ["HERMES_HOME"] = state
        socket.create_connection = deny_network
        socket.socket.connect = deny_network
        socket.socket.connect_ex = deny_network
        sys.path.insert(0, str(hermes_repo))
        from agent.prompt_builder import build_context_files_prompt
        LOADER = build_context_files_prompt
        revision = subprocess.run(["git", "-C", str(hermes_repo), "rev-parse", "HEAD"],
                                  capture_output=True, text=True).stdout.strip() or "unknown"
        print(f"Installed-loader checks only; Python {sys.version.split()[0]}, "
              f"Hermes source revision {revision}.", flush=True)
        result = unittest.TextTestRunner(verbosity=2).run(
            unittest.defaultTestLoader.loadTestsFromTestCase(DiscoveryContract))
    raise SystemExit(not result.wasSuccessful())
