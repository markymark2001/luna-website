# Reviewing Workflow

Read and follow this file only when your sole task is to review the codebase,
a branch, a pull request, or an implementation and report findings. This
workflow is a narrow exception to the normal `AGENTS.md` implementation flow.
If you are implementing changes and only running review as part of that
end-to-end work, do not use this workflow.

## Rules

- Do not invoke `./.codex/scripts/codex-review.sh`, `codex exec review`, or any other reviewer agent.
- Do not edit files, write code, or apply patches.
- Do not create, switch, or delete branches.
- Do not stage, commit, push, tag, or create/update pull requests.

## Review Focus

In addition to normal review, step back and review the shape of the change:

- Judge whether the implementation is the right fit for a static GitHub Pages
  site, or whether it introduces unnecessary tooling, runtime dependencies, or
  fragile hosting behavior.
- Flag broken links, missing public pages, incorrect custom-domain assumptions,
  inconsistent legal/support content, accessibility regressions, and responsive
  layout problems.
- Review HTML semantics, page titles, metadata, navigation, and CSS changes for
  public-site quality.
- Treat maintainability as blocking when the change makes future website edits
  harder without a documented, bounded reason.
