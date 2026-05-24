# Legal Page Typography Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Privacy Policy and Terms of Service typography match the Taia site design system while staying readable for long legal text.

**Architecture:** Update only the legal page CSS in `styles/pages.css`. Keep generated legal HTML and shared shell unchanged, because the page structure is already correct.

**Tech Stack:** Static HTML, CSS modules, local `python3 -m http.server`, Codex browser evidence.

---

### Task 1: Restyle Legal Reading Surface

**Files:**
- Modify: `styles/pages.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] Reduce legal page width to a readable long-form measure.
- [ ] Make legal H1 use a page-heading scale instead of landing-page display scale.
- [ ] Make legal H2/H3 use smaller section-heading styles with normal letter spacing.
- [ ] Make legal body and strong text use primary `--ink`; keep `--brown-action` for links and reserve `--muted` for non-primary supporting UI.
- [ ] Browser-check `privacy.html` and `terms.html` on desktop and mobile.
- [ ] Verify no console errors and no horizontal overflow.
