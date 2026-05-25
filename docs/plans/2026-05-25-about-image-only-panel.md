# About Image Only Panel Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the stats cards from the About team media panel so the section renders as only the image.

**Architecture:** Keep `media-stat-panel` as the reusable media container and add an image-only modifier for panels without overlay content. Remove the stats grid markup from the About fragment, rebuild generated HTML, verify desktop/mobile rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Remove Stats Overlay Cards

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Make the About media panel image-only**

Change the About panel markup in `src/pages/about.html` to:

```html
<div class="media-stat-panel media-stat-panel--image-only" aria-label="Taia team image">
  <img class="media-stat-panel__image" src="https://website.lunaapp.io/about-stats.webp" alt="">
</div>
```

- [ ] **Step 2: Add image-only modifier CSS**

Add this modifier to `styles/components.css`:

```css
.media-stat-panel--image-only {
  min-height: auto;
  aspect-ratio: 1344 / 896;
}
```

- [ ] **Step 3: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` has no `.stat-card`, `.stat-card__value`, `.stat-card__label`, or `.media-stat-panel__grid` markup in the About team section.

- [ ] **Step 4: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-image-only-panel` in the Codex browser and verify:

```js
document.querySelector('.about-who .media-stat-panel--image-only') !== null
document.querySelectorAll('.about-who .stat-card').length === 0
document.querySelector('.about-who .media-stat-panel__image').complete === true
document.querySelector('.about-who .media-stat-panel__image').naturalWidth > 0
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the section renders just the loaded image and there is no horizontal overflow.

- [ ] **Step 5: Commit and push**

Run:

```bash
git add src/pages/about.html about.html styles/components.css docs/plans/2026-05-25-about-image-only-panel.md
git commit -m "Show about team image without stat cards"
git push origin HEAD:codex/homepage-header-hero
```
