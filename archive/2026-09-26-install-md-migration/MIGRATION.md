# Migration to a portable INSTALL.md

Date: 2026-09-26. Baseline: [`f1c19fcf8d930c2e117ad6e4aeb89cb3fd895ab4`](https://github.com/VAMFI/claude-user-memory/commit/f1c19fcf8d930c2e117ad6e4aeb89cb3fd895ab4).

## Purpose

The original Agentic Substrate combined Claude Code-specific agents, skills, commands, hooks, shell installers, and global instructions. Its useful core was a workflow: use evidence, plan as needed, execute, verify, and preserve useful knowledge.

The portable beta makes that workflow the product. `INSTALL.md` is an agent-guided protocol that adapts to the user's existing harness and permissions. It is not a single script that installs identically on every system. Its minimal configuration avoids new providers, services, databases, and compulsory memory systems. Hardware inspection is reserved for requested resource-sensitive components.

The installed entry stays small. The installer document itself is not an always-loaded prompt, and the legacy agent collection is not imported by default. Existing native memory remains at its current setting; optional journal memory is a separate choice.

## Repository structure

```text
README.md
INSTALL.md
archive/
  2026-09-26-install-md-migration/
    baseline-manifest.json
    MIGRATION.md
    RESEARCH.md
    VALIDATION.md
    legacy/                      # Exact original tracked tree
    ...                          # Migration verification tooling and evidence
```

All 134 baseline tracked files were relocated under `legacy/`, preserving their relative paths and bytes, including hidden directories, original scripts, older archives, and the original license and attribution. The [manifest](baseline-manifest.json) maps baseline paths to archived paths and records hashes and Git modes. Git history is retained. New migration documents and tests are outside the preserved tree.

The active root has only `README.md`, `INSTALL.md`, and `archive/` as tracked entries. The original MIT license and attribution are intentionally linked from the root README. No GitHub license badge or automatic detection result is claimed.

Archived material is historical. It contains instructions and claims that describe the old system, and should not be imported or executed as part of the portable setup. Moving an instruction file into an archive does not guarantee that every harness will ignore it while browsing that directory; discovery behavior varies by runtime.

## Changes in behavior

| Original approach | Portable beta |
|---|---|
| Claude-specific global installation | Project scope by default, verified native integration |
| Broad agent and hook collection | One small workflow; additions only when selected |
| Assumed tools and external memory services | Capability checks and reuse of existing native behavior |
| Large global instruction material | Short managed pointer and selective core/knowledge loading |
| Inherited speed and productivity claims | Explicit evidence and compatibility limits |
| Script-specific configuration edits | Backups, ownership receipts, conflict detection, and removal contract |

Old root script URLs, including `/main/install.sh` and `/main/update.sh`, are intentionally retired by the archive move. A pinned raw copy of the old installer is not a reliable workaround: its download mode still clones mutable `main`. For historical review, use a complete checkout of the baseline commit without automatically executing its scripts.

This GitHub reorganization does not uninstall or update anything on existing users' machines. Legacy files under `~/.claude/`, merged global instruction content, enabled hooks, and MCP registrations remain until individually changed. A new project-local installation does not neutralize old global instructions.

### Existing users

1. Privately back up current global and project instructions, settings, substrate files, and relevant local data. Preserve prior backups and receipts; never upload credentials.
2. Inventory the actual installation using its local manifest and a reviewed baseline. A manifest is evidence, not proof that a file has no user customizations.
3. Diff and disable only identified legacy prompt sections, hook registrations, agent/skill/command files, and MCP entries. Preserve custom edits, unrelated tools, data, knowledge, histories, and memory. Leave uncertain files for review instead of bulk deletion.
4. Start a fresh session and verify that the removed legacy guidance is inactive.
5. Try the new `INSTALL.md` in one project, retain current native memory settings, and verify activation and undo before wider use.

Do not run the archived uninstaller or rollback scripts blindly. Their historical behavior can delete files without reliable ownership checks or replace entire configuration directories. Migration should preserve current customizations and remove only changes whose ownership has been established.

## Work performed

Six roles separated research, planning, implementation, testing, independent verification, and final documentation. The migration preserved the legacy tree, promoted a refined portable protocol, added a concise README, and recorded validation without publishing private logs.

The protocol grew from a locally tested draft. Observed issues led to explicit handling for native instruction precedence, the active executable versus a different binary on `PATH`, private test state, same-version no-op installs, recoverable writes, and conservative rollback. A fresh beta snapshot was also installed in Codex. The published document subsequently added an optional-journal privacy requirement; that disabled feature was not live-tested. Validation records exact hashes so previous results are not presented as coverage of every final line.

[VALIDATION.md](VALIDATION.md) separates live model runs, direct runtime-loader tests, generated-installer checks, and remaining work. [RESEARCH.md](RESEARCH.md) records the sources and version boundaries behind the adaptation guidance.

## Rollback and compatibility

A maintainer can reverse the repository migration with a normal Git revert of its merge/change commit, reviewed against subsequent changes. Avoid history rewrites or a force push. Repository rollback does not undo an installation in another project; that requires the project's own receipt and backup procedure.

The source baseline and preservation manifest also allow individual historical files to be recovered without reverting the new entry points. Restore only the needed file after reviewing its historical purpose.

The project name and GitHub URL remain unchanged. No migration automatically changes a user's model, provider, plugins, memories, or global instructions. Any GitHub description or topic update should describe the portable beta without claiming results beyond the validation record.

## Next work

Build deterministic, versioned adapters behind the document; repeat live tests for the final protocol; validate supported memory operations independently; and expand the operating-system and harness matrix. Add interrupted-install recovery and upgrade tests before treating this as a production installer. Every new claim should point to a reproducible check and its limitations.
