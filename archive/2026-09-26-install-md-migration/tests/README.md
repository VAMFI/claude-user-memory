# Reproduce the checks

These tests have different scopes. None turns the natural-language [installation protocol](../../../INSTALL.md) into a deterministic installer. Python 3 and Git are needed for repository checks; no package installation or model calls are required.

From the repository root:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 archive/2026-09-26-install-md-migration/tests/repository_checks.py
```

This checks the two-file public root, every archived file against the pinned original Git tree and SHA-256 manifest, executable bits on Unix, archive completeness, and local links/anchors in active documentation. The original commit must be present in Git history; a shallow clone that omits it will fail explicitly. Historical links inside `legacy/` are intentionally excluded. External URLs are not fetched. No assertion that a policy sentence exists counts as a behavioral installation pass.

After staging a migration, add `--check-index` to verify the Git index also contains every original blob and mode. Archived ignore rules can otherwise hide previously tracked files when they move to a new path. All runners also set `sys.dont_write_bytecode` to avoid creating untracked Python caches in this intentionally minimal repository.

## Offline Hermes loader checks

Use an existing, reviewed Hermes checkout and its existing Python environment:

```sh
PYTHONDONTWRITEBYTECODE=1 "$HERMES_PYTHON" archive/2026-09-26-install-md-migration/tests/hermes_discovery.py --hermes-repo "$HERMES_REPO"
```

Set `HERMES_PYTHON` to that environment's Python executable and `HERMES_REPO` to its source directory. The script sets a temporary `HERMES_HOME` before importing the real loader, skips global SOUL loading, and blocks Python socket connections. It exercises six discovery behaviors observed in Hermes 0.18.2: fallback loading, native-file precedence, ancestor behavior, YAML frontmatter, and an empty negative control. A different release may correctly differ; investigate a failure instead of assuming it supports this adapter. These checks do not test a live model, tool execution, persistent memory, or an entire Hermes installation.

## Reviewed generated Codex fixture

The optional fixture checks test a particular agent-generated `undo.py` exposing `rollback(root, apply)`. That helper is **not** an installer shipped by this repository. The script imports and executes it, so inspect the supplied helper before running these checks. Mutating test cases use disposable copies; that is test isolation by convention, not an OS security sandbox.

Keep private fixture metadata outside the repository. It must include `path`, `active`, `shadow`, and `original` (a map of relative paths to their original UTF-8 text). `active` is the actual native instruction file; `shadow` is a deliberately inactive fallback. The original local runner's `fixtures.codex` envelope is also accepted. Do not publish credentials, machine paths, or original user configuration.

```sh
PYTHONDONTWRITEBYTECODE=1 python3 archive/2026-09-26-install-md-migration/tests/check_installed_fixture.py \
  --fixture-metadata "$PRIVATE_FIXTURE_METADATA" \
  --expected-cli-version "$TESTED_CODEX_VERSION" \
  --trust-reviewed-undo
```

Ten behavior checks cover recorded file hashes and original backups, preservation of existing instructions, read-only preview, repeated removal, preservation of later edits and notes, managed-block conflicts, modified core files, damaged backups, path traversal, and symlink escapes. Hosts unable to create symlinks report a skip explicitly. This does not test live-model removal or promise compatibility with every generated receipt/helper format.

The fresh beta 0.3 run generated a different receipt and a helper exposing `run(root, apply)`. Its corresponding runner uses private metadata containing `project` (the fixture path) and `originals` (original UTF-8 texts), plus the exact tested document digest:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 archive/2026-09-26-install-md-migration/tests/check_release_fixture.py \
  --fixture-metadata "$PRIVATE_RELEASE_METADATA" \
  --expected-source-sha256 "$TESTED_INSTALL_SHA256" \
  --expected-cli-version "$TESTED_CODEX_VERSION" \
  --trust-reviewed-undo
```

Its ten checks also verify the source digest, disabled-memory/no-journal state, original backup permissions on Unix, schema rejection, and that the source fixture stays unchanged. Both helper runners require the particular privately generated fixture; the repository includes test code, not those private fixtures or a universal rollback implementation.

## Live acceptance checks

Use disposable project/state directories and the user's existing authorized runtime/model/provider. Review generated helpers before executing them. Do not change provider, purchase credits, install dependencies, or modify global memory merely to obtain a pass. Fingerprint relevant personal configuration before and after testing, and remove only test-owned side effects.

| Case | Required evidence |
|---|---|
| Minimal install | Original bytes backed up; unrelated instructions and settings preserved; no unrequested dependencies, hooks, or automatic delegation. |
| Native memory disabled | Its setting stays disabled; no new persistent journal or memory engine without user agreement. |
| Native memory enabled | Existing supported behavior retained; no duplicate store or direct internal-store edits. |
| Optional private journal | Explicit consent precedes creation; knowledge contents are Git-ignored before notes are written unless shared version control was separately authorized. |
| Native activation | A fresh session reports an unpredictable token present only in native context, with no instruction-file read and no token in its prompt/history. |
| Core retrieval | That session reads the managed pointer's target and reports the expected heading; distinguish this from native activation. |
| Negative control | An isolated session without project instructions cannot return the random token. |
| Same-version repeat | Hash and file-list snapshots show zero writes for an already-current installation; no duplicate blocks or backup chains. |
| Scope conflict | A shadowing ancestor outside the authorized scope leads to a clearly reported scope decision, not a silent global edit. |
| Concurrent edits | A file changed after preflight is preserved and the conflict is reported before replacement. |
| Interruption | An interrupted write leaves a recoverable operation journal and no false complete receipt; restart preserves unrelated edits. |
| Update | A pinned revision produces reviewable changes, preserves user additions, and repeats verification. |
| Removal | Original or unchanged owned content is removed safely, later user edits and notes survive, conflicts preserve files. |
| Memory persistence | A separate supported cross-session probe passes; reading a file in one session is insufficient. |

Record each case as passed, failed, blocked, or not run, with the runtime and exact source digest. The table is an acceptance plan, **not a claim that all cases have passed**. See the [validation report](../VALIDATION.md) for observed results.
