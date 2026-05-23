# Spec Writing Workflow

Read and follow this file for product specs and durable design specs.

The purpose of a spec is to lock in product decisions with the user.
Spec writing is collaborative research and decision capture, not normal
implementation work.

## Rules

- Specs live in `docs/specs`.
- Do not commit or push a spec until the user approves it.
- Only write decisions, wording, or open questions the user approved.
- Never invent requirements, fill gaps from gut feel, or turn agent implementation choices into product decisions.
- Use `docs/workflows/brainstorming.md`, repo research, and web search to understand production patterns before proposing options.
- Bring findings and tradeoffs back to the user before writing them into the spec.
- Keep the spec as short as possible.
- Do not run the Codex review agent (`./.codex/scripts/codex-review.sh`) while this workflow is active; specs are collaborative brainstorming and decision capture, so the normal Review phase does not apply.

## Procedure

1. Research the problem, repo context, and relevant production patterns.
2. Present options, tradeoffs, and recommendations to the user.
3. Write or update the spec only with approved decisions.
4. Put unresolved items under `Open Questions`; do not assume the answer.
5. Commit and push the spec only after the user approves it.
6. After the user approves the spec and implementation, return to the normal `AGENTS.md` implementation workflow.
