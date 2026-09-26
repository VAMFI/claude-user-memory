# Agentic Substrate

A small, portable workflow for an agent you already use: **research what is uncertain, plan proportionally, act, verify, and retain useful knowledge**.

Start with **[INSTALL.md](INSTALL.md)**. Your agent adapts the setup to its actual tool, operating system, permissions, and project. It keeps your current model and provider and leaves native memory at its current setting.

**Status: agent-guided portable beta.** A fresh portable-beta Codex installation and an earlier prototype have been exercised locally. Hermes has offline startup-loader coverage; its live installation test was blocked by the configured provider's balance. This is not yet a deterministic installer or a compatibility guarantee for every agent. See the [validation record](archive/2026-09-26-install-md-migration/VALIDATION.md).

## Install with your agent

Give your agent [INSTALL.md](INSTALL.md), or its [raw document](https://raw.githubusercontent.com/VAMFI/claude-user-memory/main/INSTALL.md), and say:

> Read INSTALL.md and install its minimal Agentic Substrate setup in this project. Adapt it to this tool and operating system, preserve my existing configuration, verify the result, and provide an undo procedure. Keep my current model, provider, and memory settings. Ask before adding persistent memory or making changes outside this project.

For repeatable installations, use the document from a reviewed commit and have the agent record that revision. The raw `main` link above changes as the project evolves. Reading or reviewing the document alone does not authorize installation.

The usual result is one short addition to the tool's native project instructions, a small `.agentic-substrate/CORE.md`, and an installation receipt with private backups and removal instructions. The always-loaded addition targets **200 words or fewer**; the full installer and old prompt collection are not copied into every session.

For chatbots without file access, the document describes a manual instruction pack. Persistence remains manual or session-only unless that tool's behavior is verified. Optional local inference needs a separate hardware check; the minimal setup requires no GPU, database, Docker, model download, or background service.

## What the project does

The core idea is to improve how an agent works and what useful context it can retrieve. It does not train or modify model weights.

- **Work proportionally.** Straightforward tasks stay direct; complex or uncertain work gets research and a plan.
- **Verify outcomes.** Report observed results, failures, and checks that could not run.
- **Remember selectively.** Keep supported decisions and solutions with enough context to check them later. Retrieve relevant notes rather than loading an entire archive.
- **Keep changes reversible.** Preserve original files, record owned changes, avoid duplicate installations, and retain later user edits during removal.

Native memory can help with recurring preferences and lessons across sessions, but its behavior depends on the harness. The default is to preserve its existing setting and avoid adding a second memory engine. A project-local Markdown journal is optional and requires agreement. Memory persistence has not been tested in this migration.

## Validation at a glance

| Environment | Evidence | Limit |
|---|---|---|
| Codex desktop CLI `0.158.0-alpha.2`, `gpt-6-astra`, macOS 26.1 arm64 | Fresh beta install, native activation/core retrieval, negative control, and repeat with zero file changes passed; 10 independent ownership/undo checks passed | One optional-journal privacy refinement followed the tested snapshot; journal and native memory remain unverified |
| Hermes `0.18.2` / `2026.7.7.2`, macOS 26.1 arm64 | Six direct startup-loader tests passed against the installed source | Live `glm-5.2`/Z.ai test stopped at insufficient balance; installation and memory remain unverified |
| Other harnesses, Linux, Windows, manual chatbot use | Adaptation guidance only | Not exercised end to end |

Prompt guidance is not an enforcement mechanism. No performance gain or universal compatibility is claimed. Full outcomes, including a timed-out repair session and known coverage gaps, are in [VALIDATION.md](archive/2026-09-26-install-md-migration/VALIDATION.md).

## Migration and contributions

This repository was originally a Claude Code prompt, hook, and installer collection. The September 2026 migration keeps every original tracked file under [the migration archive](archive/2026-09-26-install-md-migration/legacy/), with a [preservation manifest](archive/2026-09-26-install-md-migration/baseline-manifest.json). The old installer scripts are historical and are no longer supported entry points. Old raw links to root scripts no longer resolve; use `INSTALL.md` for new setup.

Read [MIGRATION.md](archive/2026-09-26-install-md-migration/MIGRATION.md) for the rationale and rollback approach, [RESEARCH.md](archive/2026-09-26-install-md-migration/RESEARCH.md) for primary sources, and [VALIDATION.md](archive/2026-09-26-install-md-migration/VALIDATION.md) for how to extend testing.

Useful contributions include verified harness discovery behavior, deterministic adapters, interruption recovery, upgrade/removal tests, and validation on additional operating systems. Include the exact runtime, model/provider, protocol revision, commands, and observed outcome. Keep private paths, credentials, account data, and raw conversations out of submissions. Check existing project rules before inspecting archived prompts; historical instructions are not part of the new setup.

The project, including the new portable documents, uses the [MIT license](archive/2026-09-26-install-md-migration/legacy/LICENSE). The original license and attribution are preserved in the archive. The repository name remains `claude-user-memory` for continuity.
