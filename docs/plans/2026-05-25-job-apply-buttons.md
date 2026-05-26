# Job Apply Buttons Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace whole-row clickable job listings with explicit secondary Apply buttons for each open role.

**Architecture:** Keep the existing `row-list` and `row-item` primitives, but make rows non-link containers and move each `mailto:` href onto a reusable `.button.secondary` action. Add a small row action slot so the primitive supports this pattern without page-specific CSS.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Add Explicit Apply Actions

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/responsive.css`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Change rows from links to list items with buttons**

For each role in `src/pages/about.html`, use this shape:

```html
<article class="row-item">
  <span class="row-item__content">
    <strong class="row-item__title">Founding Product Designer</strong>
    <small class="row-item__subtitle">Product and brand systems</small>
  </span>
  <span class="row-item__actions">
    <em class="row-item__meta">Remote</em>
    <a class="button secondary" href="mailto:mark@mediakey.io?subject=Founding%20Product%20Designer">
      <span>Apply</span>
      <span aria-hidden="true">Apply</span>
    </a>
  </span>
</article>
```

Repeat the same structure for Founding iOS Engineer and Astrology Content Lead, preserving their existing `mailto:` subjects.

- [ ] **Step 2: Add a reusable row action slot**

Add this CSS to `styles/components.css`:

```css
.row-item__actions {
  display: inline-flex;
  align-items: center;
  gap: var(--space-4);
  flex: 0 0 auto;
}
```

- [ ] **Step 3: Keep mobile row layout stable**

Add this CSS inside the existing mobile media query in `styles/responsive.css`:

```css
.row-item__actions {
  width: 100%;
  justify-content: space-between;
}
```

- [ ] **Step 4: Build and inspect**

Run:

```bash
node scripts/build-site.mjs
git diff --check
```

Expected: generated `about.html` matches the source fragment and has no whitespace errors.

- [ ] **Step 5: Runtime evidence**

Open `http://127.0.0.1:8081/about.html?v=job-apply-buttons#jobs` in the Codex browser and verify:

```js
document.querySelectorAll('#jobs .row-item').length === 3
document.querySelectorAll('#jobs .row-item[href]').length === 0
document.querySelectorAll('#jobs .row-item .button.secondary').length === 3
[...document.querySelectorAll('#jobs .button.secondary')].every((button) => button.textContent.trim().replace(/\s+/g, ' ') === 'Apply Apply')
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: there are three non-anchor rows, each has one secondary Apply button, and the page has no horizontal overflow.

- [ ] **Step 6: Commit and push**

Run:

```bash
git add src/pages/about.html about.html styles/components.css styles/responsive.css docs/plans/2026-05-25-job-apply-buttons.md
git commit -m "Add apply buttons to job rows"
git push origin HEAD:codex/homepage-header-hero
```
