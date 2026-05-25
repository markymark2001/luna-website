# About Stats Image Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the About stats section background image with `https://website.lunaapp.io/about-stats.webp`.

**Architecture:** Keep the existing `media-stat-panel` primitive and only change the image source in the About page fragment. Rebuild generated static HTML and verify the hosted WebP renders locally.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Swap Stats Panel Image

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Update the image source**

Change the stats panel image in `src/pages/about.html` from:

```html
<img class="media-stat-panel__image" src="https://framerusercontent.com/images/3jSoIlDJyMfLx6JTWfHwuwwhjSw.png?width=2144&amp;height=730" alt="">
```

to:

```html
<img class="media-stat-panel__image" src="https://website.lunaapp.io/about-stats.webp" alt="">
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` uses `https://website.lunaapp.io/about-stats.webp` and no longer references the Framer image URL.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-stats-image` in the Codex browser and verify:

```js
const image = document.querySelector('.media-stat-panel__image');
image.currentSrc === 'https://website.lunaapp.io/about-stats.webp'
image.complete === true
image.naturalWidth > 0
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the Luna-hosted WebP is the rendered stats panel image, it has loaded, and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-stats-image.md
git commit -m "Update about stats image"
git push origin HEAD:codex/homepage-header-hero
```
