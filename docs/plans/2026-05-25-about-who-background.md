# About Who Background Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the About page background from the Who section onward use the same lighter content color as the homepage.

**Architecture:** Remove the `section-band--alt` modifier from the About Who section so it inherits the shared `section-band` background, `var(--cream-body)`, which matches the homepage content surface.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Lighten Who Section Background

**Files:**
- Modify: `src/pages/about.html`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current background**

Open `src/pages/about.html`.
Expected: the Who section uses `class="section-band section-band--alt about-who"`, which applies the darker `var(--cream-section)` background.

- [x] **Step 2: Use the shared light section background**

Change the Who section opening tag to:

```html
<section class="section-band about-who" aria-labelledby="who-we-are-title">
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: the Who section background computes to `rgb(246, 236, 220)`, matching the homepage light content background, and no horizontal overflow appears.

- [x] **Step 4: Commit and push**

Stage only the About source/generated HTML and this plan:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-who-background.md
git commit -m "Use light background for about who section"
git push origin HEAD:codex/homepage-header-hero
```
