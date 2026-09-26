# Research behind the portable protocol

Reviewed 2026-09-26. Repository baseline: `f1c19fcf8d930c2e117ad6e4aeb89cb3fd895ab4`. This is source and documentation review. Live test outcomes belong in [VALIDATION.md](VALIDATION.md).

## Core decision

Keep the workflow: understand the task, research real uncertainty, plan proportionally, execute within scope, verify outcomes, and retain supported lessons. A versioned `INSTALL.md` can tell an agent how to create a small native pointer and a portable core. It cannot guarantee identical file operations across every model or harness.

The setup preserves the existing model/provider and native memory setting. It is not a new memory engine, a replacement system prompt, or model training. A file journal is an explicit optional choice. The 200-word always-loaded target is a project design budget, not a measured provider token limit.

Activation, core retrieval, memory persistence, and rollback are separate capabilities. Evidence for one does not establish the others. Production readiness needs deterministic adapters and broader tests in addition to prose instructions.

## Harness discovery is version-specific

### Codex

Local CLI help and package information established the available runtimes, but did not completely specify native project discovery. The [official AGENTS.md documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md) describes one selected instruction file per directory: `AGENTS.override.md` before `AGENTS.md`, then configured fallback names. Discovery normally follows the Git-root-to-working-directory path, skips empty files, and observes a configurable size limit.

A pointer added after a long existing file may be truncated. The installer therefore needs a fresh-session activation check instead of assuming that file existence proves loading. A CLI found on `PATH` may also differ from the executable actually running the session; [the local validation](VALIDATION.md) encountered that difference.

The [official memory documentation](https://learn.chatgpt.com/docs/customization/memories) is the reference for supported Codex memory behavior. The portable setup leaves memory at its current setting and follows native update controls; it does not edit generated internal stores.

### Hermes

The inspected installation was `0.18.2`, revision [`540f90190f50f9518bf36632a724e0e58877a10b`](https://github.com/NousResearch/hermes-agent/tree/540f90190f50f9518bf36632a724e0e58877a10b). Its [startup loader](https://github.com/NousResearch/hermes-agent/blob/540f90190f50f9518bf36632a724e0e58877a10b/agent/prompt_builder.py) selects the first nonempty supported context type: nearest `.hermes.md`/`HERMES.md` toward the Git root, then current-directory `AGENTS.md`/`agents.md`, then current-directory `CLAUDE.md`/`claude.md`, then Cursor rules. With no Git root, native `.hermes` search is also current-directory-only. Global `SOUL.md` is separate.

That same release already has [progressive subdirectory discovery](https://github.com/NousResearch/hermes-agent/blob/540f90190f50f9518bf36632a724e0e58877a10b/agent/subdirectory_hints.py). The six local tests cover startup behavior only; they do not prove that a file will never be discovered later.

The [current Context Files documentation](https://hermes-agent.nousresearch.com/docs/user-guide/features/context-files) describes additional override and merged ancestor discovery behavior. Its startup semantics differ from the inspected installation. Inspect the running version before applying either mapping. Preserve frontmatter bytes even if the loader excludes them from model context, and do not change global `SOUL.md` to fix project discovery.

The [Hermes CLI documentation](https://hermes-agent.nousresearch.com/docs/user-guide/cli) is useful background, but installed `--help` determines available flags. The prior provider balance error blocks live certification; it is neither proof of installer failure nor a successful installation.

### Claude Code

The [current official memory documentation](https://code.claude.com/docs/en/memory), reviewed on the date above, describes direct `AGENTS.md` support beginning at `2.1.277`, subject to configuration/plugin state. Project or ancestor `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md` can suppress the fallback. User-global and managed instructions are separate; Codex's `AGENTS.override.md` must not be assumed to work equivalently.

This is documentation review only. Claude Code remains untested in the portable beta's live matrix.

### Agent Skills

The [open Agent Skills specification](https://agentskills.io/specification) defines a directory containing `SKILL.md` with YAML `name` and `description`; the name matches its folder. Discovery roots, tool permissions, and executable capabilities still depend on the host implementation. Progressive loading can reduce content loaded for a task, while advertised metadata itself adds some context.

A single optional skill can package the workflow when supported. An arbitrary `CORE.md` is not automatically a registered skill. A verified native pointer is sufficient for the minimal configuration.

## Legacy content and claims

The original philosophy and prompts explain the project's intent, but historical performance claims do not establish measured gains for this repository. The portable README and metadata therefore make no inherited speedup or productivity claim. Future comparisons should use the same harness, model, and tasks with and without the substrate.

Every baseline tracked blob and its Git mode is preserved under [legacy/](legacy/), including the [MIT license and original attribution](legacy/LICENSE). Active documentation identifies that license explicitly; no automatic license-detection result is promised. See [GitHub's licensing guidance](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) for recognition and repository presentation.

An archive directory does not technically disable instruction discovery. Legacy prompts are historical material outside the new installation; they should not be imported by default. Keep preservation checks separate from active-document quality checks so old links and claims are not silently rewritten.
