# About Hero Caret Down Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the About hero "See open roles" button icon from a right caret to a down caret.

**Architecture:** Update only the two inline SVG paths inside the About hero CTA in `src/pages/about.html`; the static build regenerates `about.html`.

**Tech Stack:** Static HTML partials, inline SVG, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Replace Hero CTA Icon

**Files:**
- Modify: `src/pages/about.html`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current icon**

Open `src/pages/about.html`.
Expected: the About hero CTA has two inline SVG paths using the right-caret path:

```html
<path d="M181.66 133.66l-80 80a8 8 0 0 1-11.32-11.32L164.69 128 90.34 53.66a8 8 0 0 1 11.32-11.32l80 80a8 8 0 0 1 0 11.32z"/>
```

- [x] **Step 2: Replace both paths with down caret**

Change both hero CTA SVG paths to:

```html
<path d="M213.66 101.66l-80 80a8 8 0 0 1-11.32 0l-80-80a8 8 0 0 1 11.32-11.32L128 164.69l74.34-74.35a8 8 0 0 1 11.32 11.32z"/>
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: the About hero CTA remains `button primary`, the icon path is the down caret, and no horizontal overflow appears.

- [x] **Step 4: Commit and push**

Stage only the About source/generated HTML and this plan:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-hero-caret-down.md
git commit -m "Use down caret on about hero CTA"
git push origin HEAD:codex/homepage-header-hero
```
