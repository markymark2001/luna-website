# About Hero Primary CTA Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the About hero "See open roles" CTA use the primary button treatment.

**Architecture:** Update only the About source partial so the generated `about.html` receives `button primary` from the build script. Keep button primitives unchanged.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Switch About Hero CTA To Primary

**Files:**
- Modify: `src/pages/about.html`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current CTA class**

Open `src/pages/about.html`.
Expected: the hero open roles link uses:

```html
<a class="button secondary" href="#jobs">
```

- [x] **Step 2: Switch to primary**

Change the hero open roles link to:

```html
<a class="button primary" href="#jobs">
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: the About hero CTA has class `button primary`, uses the dark primary background, and no horizontal overflow appears.

- [x] **Step 4: Commit and push**

Stage only the About source/generated HTML and this plan:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-hero-primary-cta.md
git commit -m "Use primary CTA on about hero"
git push origin HEAD:codex/homepage-header-hero
```
