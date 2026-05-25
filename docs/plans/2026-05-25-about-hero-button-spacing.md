# About Hero Button Spacing Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Increase the About hero title-to-button spacing so the mission block breathes correctly.

**Architecture:** Keep the change scoped to the existing `.about-hero__actions` spacing rule in `styles/pages.css`. Rebuild generated static HTML and verify the About hero at desktop and mobile widths.

**Tech Stack:** Static CSS, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Double About Hero CTA Gap

**Files:**
- Modify: `styles/pages.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current spacing**

Open `styles/pages.css` and find:

```css
.about-hero__actions {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--space-4);
  margin-top: var(--space-5);
}
```

Expected: title-to-button gap is currently `var(--space-5)`.

- [x] **Step 2: Double the title-to-button gap**

Update `styles/pages.css` to:

```css
.about-hero__actions {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--space-4);
  margin-top: var(--space-10);
}
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: the button sits farther below the mission title, the hero still fits cleanly, and no horizontal overflow appears.

- [x] **Step 4: Commit and push**

Stage only this CSS and plan:

```bash
git add styles/pages.css docs/plans/2026-05-25-about-hero-button-spacing.md
git commit -m "Adjust about hero button spacing"
git push origin HEAD:codex/homepage-header-hero
```
