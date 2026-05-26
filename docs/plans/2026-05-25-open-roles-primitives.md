# Open Roles Primitives Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the About open roles section to use reusable design-system primitives instead of one-off `about-job` styles.

**Architecture:** Add shared `section-intro`, `row-list`, and `row-item` primitives in `styles/components.css`. Update About Jobs markup to use those primitives, keep only `about-jobs` for page-specific section placement, and move mobile row stacking into the shared responsive primitive.

**Tech Stack:** Static HTML partials, modular CSS design-system files, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Extract Open Roles Components

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm one-off styles**

Open `styles/pages.css` and confirm the open roles section uses one-off classes:

```css
.about-jobs__heading
.about-jobs__list
.about-job
```

- [x] **Step 2: Add shared primitives**

Add reusable classes to `styles/components.css`:

```css
.section-intro { ... }
.row-list { ... }
.row-item { ... }
.row-item__content { ... }
.row-item__title { ... }
.row-item__subtitle,
.row-item__meta { ... }
```

- [x] **Step 3: Update About markup to use primitives**

Replace About Jobs wrappers/classes with:

```html
<div class="wrap about-jobs__inner">
  <div class="section-intro">
  <div class="row-list" aria-label="Open positions">
  <a class="row-item" ...>
```

- [x] **Step 4: Remove one-off Jobs CSS**

Remove `.about-jobs__heading`, `.about-jobs__list`, `.about-job`, and child selectors from `styles/pages.css`.
Keep only:

```css
.about-jobs {
  padding-bottom: clamp(48px, 7vw, 88px);
}

.about-jobs__inner {
  display: grid;
  gap: var(--space-12);
}
```

- [x] **Step 5: Move responsive behavior to shared row primitive**

In `styles/responsive.css`, replace `.about-job` mobile styles with `.row-item` mobile styles.

- [x] **Step 6: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=open-roles-primitives#jobs` in the Codex browser at desktop and mobile widths.
Expected: open roles still renders as centered intro plus three role rows, About markup uses shared primitives, no `.about-job` or `.about-jobs__heading` classes remain, and no horizontal overflow appears.

- [x] **Step 7: Commit and push**

Stage only the About source/generated HTML, CSS, and this plan:

```bash
git add src/pages/about.html about.html styles/components.css styles/pages.css styles/responsive.css docs/plans/2026-05-25-open-roles-primitives.md
git commit -m "Extract open roles list primitives"
git push origin HEAD:codex/homepage-header-hero
```
