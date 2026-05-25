# IMMUTABLE AGENT CONTRACT

This entire file is immutable during routine project work.
Do not edit `AGENTS.md` unless the user explicitly asks to change it.

## Product Purpose

Public website for astrology app.

## Operating Posture

This codebase is agent-operated. Treat every user request as end-to-end: plan,
implement, verify, review, commit, and push without waiting for step-by-step
permission unless the user explicitly asks to discuss, plan, or pause. 

Use repo docs, available tools, local context, established patterns, documented workflows,
repo helpers, and relevant MCP/plugin capabilities before inventing workflows or asking for clarification.
Make reasonable assumptions when safe. Stop with a concrete blocker when progress requires missing access,
missing external setup, an unsafe production action, or an explicit user decision.

Read `architecture.md` before planning or making code changes.
Scan `docs/` for relevant durable context before editing.

Before implementing anything, comprehensive web research is required: always use web search, official SDK/framework/library/product documentation, and multiple reputable examples. Prefer established patterns over invention.

When doing multi-step implementations, read and follow `docs/workflows/writing-plans.md` to create a plan; save agent-owned implementation plans in `docs/plans`.

Keep `main` deployable. Keep the codebase secure, DRY, maintainable, and free of dead code. Refactor whenever the root-cause fix requires it.

Runtime evidence is required when the claim depends on browser-visible behavior:
layout, styling, navigation, accessibility, public page rendering, GitHub Pages
behavior, or user-reported website behavior. If selected, follow
`docs/workflows/runtime-evidence.md`.

Push means commit and push every completed implementation.

## Workflows

Workflows are procedural runbooks.

- Brainstorming, design shaping, or pre-spec product clarification:
  read and follow `docs/workflows/brainstorming.md` before writing a spec or implementation plan.
- Debugging, verification failures, build failures, performance issues, integration issues, or other unexpected behavior:
  read and follow `docs/workflows/systematic-debugging.md` before proposing or applying fixes.
- Spec writing or product decision specs:
  read and follow `docs/workflows/specs.md` before acting.
- Runtime evidence selected by the agent, local website smoke checks, or browser console inspection:
  read and follow `docs/workflows/runtime-evidence.md` only when the agent selects runtime evidence,
  runs local website actions, or inspects browser console output.

## Documentation Rules

When documentation may matter, list and search `docs/`, then read any matching
doc before editing the related surface. Document intended durable behavior,
contracts, workflows, and architecture decisions. Do not document routine small
changes, obvious implementation details, or temporary process notes; update docs
when a future agent would need the intended operating model to work safely.

## Required Checks

For every surface you touched, run every listed check for that surface:

- Static HTML/CSS/content: inspect the changed files, serve the site locally,
  and use Codex browser evidence for changed public pages.
- Navigation/link changes: verify all affected links in the browser and, when
  useful, with `curl` against the local server.
- Legal/support page content changes: verify the affected page renders in the
  browser and that navigation still reaches it.
- Repo/docs/workflows: inspect the affected Markdown and run no browser evidence
  unless the docs describe browser-visible behavior.

## Checkout Rules

Never create, switch, or request branches for routine work in this repository.
Always stay on the branch already checked out in the current worktree. Assume
existing local changes are intentional and may come from the user or parallel
agents; work with them instead of treating a dirty worktree as a blocker.

Always commit and push completed implementation work.
If the current branch is `main`, push `main` and do not open a PR. If the
current checkout is a worktree or non-`main` branch, push that branch and create
a non-draft pull request into `main`. If the checkout is detached in a worktree,
create one `codex/` branch at the current HEAD, then push that branch and open a
non-draft PR into `main`. Before creating or updating a pull request, verify the
branch has no merge conflicts with `main`.

## Codebase Rules

Do not add fallback or legacy paths unless they are needed for public URL
compatibility.

For architecture-sensitive changes, update the matching doc in the same PR.
Architecture-sensitive means hosting/deployment behavior, URL structure, legal
page ownership, verification workflow, or agent workflow.
