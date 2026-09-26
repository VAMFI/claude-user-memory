# Validation record

Date: 2026-09-26. This is a sanitized account of local observations, not a claim of universal compatibility. Raw session logs remain private because they contain local paths, random test markers, and runtime context.

## Scope and provenance

The live tests exercised an earlier `INSTALL.md` draft (v0.2) and a frozen portable beta (v0.3) on one macOS 26.1 arm64 machine. The published document includes one later journal-privacy refinement. Results apply to the stated snapshots and selected features; they do not certify every model or harness.

The latest tested v0.2 draft had SHA-256 `f36f6ef5e99bbc7db651c9d40c1cfd145e1af401c2a1c6a13ad4b8d85d4b989c`. The first live install preceded some v0.2 refinements; a later repair and completed repeat check brought the fixture's source reference to that hash. Each phase below retains its own outcome.

Test projects used disposable directories. The Codex child process used its `workspace-write` sandbox. Hermes used a temporary `HERMES_HOME` and a disposable working directory; those paths alone are not an OS-enforced sandbox. Tests retained the already-configured model/provider and did not install dependencies or purchase resources.

## Fresh portable beta (v0.3) Codex run

Using the same Codex runtime, model, OS, and isolation described below, a fresh live install exercised snapshot SHA-256 `24e8f2d353250593ef18535c02cab38624e2d89858adb3dbfda95026f088be53`. It completed with exit 0 and an explicit completed-turn event in 458.3 seconds. It added a 52-word managed entry, preserved existing fixture instructions, and created the core, receipt, undo implementation, and private backups.

After that snapshot was frozen, the public document added one requirement: an optional knowledge journal is ignored by Git unless the user explicitly chooses versioned sharing. The published `INSTALL.md` SHA-256 is `8a55c7a2d9da513a5e699392df0f2a5f7d6235c2c58ae81566cc213e0e06624c`. Journal mode was disabled during the live run, so that refinement is not live-tested. Native memory persistence is also unverified.

Ten fresh independent checks passed against this newly generated installation on disposable copies and were then rerun successfully using the configurable public `check_release_fixture.py` helper. They verified receipt source/runtime and owned hashes; exact originals and backup modes; read-only preview; exact and repeat removal; retention of later edits and knowledge; managed-block and changed-core conflicts; corrupt backups; traversal; symlink escape; and unsupported receipt schema. The live fixture remained unchanged. This is a second bounded generated-implementation evaluation, not certification of a shipped deterministic adapter.

A fresh activation session completed in 10.4 seconds, exit 0. It reported the expected marker from already-loaded native context without reading native instruction files, then read the core and returned its heading. An independent negative control completed in 6.0 seconds, exit 0, returning `UNKNOWN` without tool calls or files. Both checks made zero project writes.

A fresh repeat installation session completed in 64.1 seconds, exit 0 with an explicit completed-turn event and `CURRENT`. A before/after snapshot showed zero changed files and no duplicate backups. This beta run used the flags shown for the earlier run, with no `--ignore-rules` flag and no dependency or provider changes.

## Earlier v0.2 Codex observations

The executable already bundled with the desktop application reported `0.158.0-alpha.2`. Tests used `gpt-6-astra` through the existing ChatGPT login. A different executable found on `PATH` reported `0.142.0`; it rejected that model before installation. This distinction motivated active-runtime evidence in the protocol.

The fixture started with an `AGENTS.override.md`, an `AGENTS.md` fallback, and an existing `.gitignore`. A random harmless context marker appeared only in the selected native instruction file. The test prompt did not reveal the marker.

| Check | Observed outcome |
|---|---|
| Older `PATH` CLI compatibility | Rejected the configured model before fixture changes |
| Prototype installation using desktop CLI | Completed, exit 0; added a 53-word managed entry and created core, receipt, backups, recovery journal, and undo implementation |
| Existing content | Original instructions and fallback remained; private backup files had restrictive permissions and ignore rules |
| Fresh-session native activation | Completed, exit 0; reported the native-context marker without opening native instruction files |
| Lazy core retrieval | The fresh session read `CORE.md` and reported its heading |
| Negative control | An independent empty project returned `UNKNOWN`, without tool calls or file writes |
| Runtime/source receipt repair | Wrote corrected administrative records but timed out after 600 seconds following connection retries; the repair session itself did not complete successfully |
| Later fresh repeat check | Completed, exit 0; reported `CURRENT`; a file snapshot showed zero changes or duplicate backups |
| Independent installation/undo checks | 10 passed against the generated installation and undo implementation after correction |

The ten independent checks covered receipt/hash/backup consistency; existing instruction preservation; read-only removal preview; exact untouched rollback and repeat no-op; retention of appended user edits and user-created knowledge; managed-block conflicts; changed core content; corrupt backups; `..` path escape; and symlink escape. These checks validate the implementation generated in this fixture. They do not prove that another model will generate an equally safe installer from prose.

The Codex command used the equivalent of:

```text
<verified-desktop-codex> exec --ignore-user-config --ephemeral
  --skip-git-repo-check -C <fixture> -s workspace-write
  -c approval_policy="never" -m gpt-6-astra
  -c model_reasoning_effort="high" -c features.plugins=false
  -c features.memories=false -c features.multi_agent=false
  --json -o <output> <test-prompt>
```

The first install also used `--ignore-rules`; subsequent calls omitted it. Codex's flag in that runtime refers to execution-policy rules, not native project-context discovery. Do not copy test flags into a user's production configuration or weaken their configured controls to obtain a pass.

Despite `--ignore-user-config` and `--ephemeral`, the runtime added a temporary project trust entry to personal configuration. Cleanup removed only the test-owned entry. A final hash check matched the pre-test configuration; unrelated edits were not overwritten. This is why configuration fingerprinting remains part of future live-test hygiene.

## Hermes observations

The installed runtime reported `0.18.2` / `2026.7.7.2`, upstream revision `540f9019`, with Python 3.11.15. Its configured model/provider were `glm-5.2` and Z.ai.

The live call used the equivalent of:

```text
HERMES_HOME=<temporary-state> hermes chat --cli -Q --source tool
  --max-turns 30 --provider zai -m glm-5.2
  -t terminal,file -q <installation-prompt>
```

It stopped with HTTP 429 indicating insufficient balance or no resource package. The project fixture was unchanged. No provider switch or new paid request sequence was used to work around the blocker. **Live installation, activation, removal, and memory persistence are unverified for Hermes.**

Six offline tests called the installed `agent.prompt_builder.build_context_files_prompt` directly and passed:

1. `AGENTS.md` fallback loads when no higher-priority nonempty context file is present.
2. Native `.hermes.md` context takes startup precedence over that fallback.
3. Native context is found from a project subdirectory.
4. The `AGENTS.md` startup fallback is not inherited from the parent directory in this inspected version.
5. YAML frontmatter is not injected into the resulting context.
6. An empty project supplies no activation marker.

These are **startup-loader tests**, not a complete Hermes discovery or live-agent suite. The same release has additional progressive discovery code; current upstream documentation also describes behavior that differs from the inspected startup loader. See [RESEARCH.md](RESEARCH.md) and verify the installed version before selecting a native instruction file.

## Personal-state preservation

For the earlier v0.2 test sequence, final pre/post hashes matched for the personal Codex config and the inspected Hermes config, environment file, and native memory files. The setup did not intentionally write personal memories, switch saved providers, or modify a live Hermes gateway.

After all fresh beta Codex sessions finished, cleanup removed exactly one test-owned project trust entry. The Codex configuration then matched the private pre-test backup byte for byte; no unrelated configuration was replaced. This fresh cleanup claim is scoped to Codex config. Hermes was not rerun, and the earlier Hermes state audit is not presented as a new beta audit. Paths, credentials, and memory contents are not published.

## Current repository checks

Migration checks are separate from the live model tests. The portable tooling and prerequisites are documented in [tests/README.md](tests/README.md).

| Checked-in helper | Observed result | What it covers |
|---|---|---|
| Repository structural and staged-index checks | 9 passed | Root layout, archived baseline integrity, document contracts, links, public-data boundaries, and the staged file set |
| Hermes startup-loader checks | 6 passed | Actual installed startup-loader behavior; no model or network call |
| Fresh beta fixture checks | 10 passed | The beta snapshot's generated implementation, through `check_release_fixture.py` on disposable copies; no live uninstall |
| Earlier reviewed-fixture checks | 10 passed | The v0.2 generated installation, through its separate compatible helper using private local fixture metadata; no live uninstall |

The staged diff whitespace check (`git diff --cached --check`) also passed.

The fresh beta's initial independent ten-case evaluation was subsequently ported into the public `check_release_fixture.py` helper and rerun successfully. The earlier `check_installed_fixture.py` targets the different v0.2 receipt/helper interface; the two are explicitly separate. Both require the appropriate private generated fixture and metadata, which are not distributed as generic installers. Passing results are not a guarantee about future generated implementations. See the test README for the broader acceptance matrix and unavailable-check handling; a skipped test is not a pass.

## Not yet established

- Live coverage of the post-freeze optional-journal privacy refinement; the exact published document differs from the tested beta snapshot as recorded above.
- A completed Hermes live installation using its configured provider.
- Native memory persistence, optional journal behavior across sessions, or synchronization.
- Live operation on Windows, Linux, Claude Code, or other harnesses and models.
- Complete interrupted-install recovery, upgrade behavior, or deterministic cross-model installation.
- Performance, token savings, productivity improvements, or measured superiority over an unchanged harness.

## Extending validation

Use a disposable project with existing rules, a conflicting fallback file, and unrelated ignore entries. Preserve the user's provider and model. Record the exact protocol revision, OS/architecture, runtime binary/version, invocation, and isolation guarantees. Do not publish raw credentials, private paths, account data, or memory contents.

Check native activation with an unpredictable marker absent from the prompt and a negative control, then check lazy core loading independently. Test repeated installation, concurrent changes, interrupted writes, upgrades, exact removal, and removal after user edits. Memory requires its own supported persistence test. A prompt guideline needs a deliberately failing case before it can be described as an enforcement gate.

Report completed, failed, blocked, skipped, and unverified results separately. Stop on provider balance or authentication blockers; changing the provider or incurring new costs needs the user's choice. Treat configuration flags as version-specific and verify personal-state cleanup without reverting unrelated changes.
