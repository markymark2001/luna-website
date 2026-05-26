# About Image Height Restore Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Keep the About team panel image-only while restoring the original `media-stat-panel` height.

**Architecture:** Remove the image-only modifier's height/aspect-ratio override so the panel uses the shared `media-stat-panel` `min-height: clamp(300px, 32vw, 365px)` contract again. The image remains absolutely positioned with `object-fit: cover`, so it fills the restored panel height without stat cards.

**Tech Stack:** Static HTML/CSS, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Restore Panel Height

**Files:**
- Modify: `styles/components.css`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Remove image-only height override**

Delete this CSS from `styles/components.css`:

```css
.media-stat-panel--image-only {
  min-height: auto;
  aspect-ratio: 1344 / 896;
}
```

Keep the `media-stat-panel--image-only` class in the markup as a semantic marker, but let it inherit the base `media-stat-panel` height.

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: generated HTML is unchanged except for normal build output, and CSS no longer contains the image-only height override.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-image-height-restore` in the Codex browser and verify:

```js
const panel = document.querySelector('.about-who .media-stat-panel');
Math.round(panel.getBoundingClientRect().height) <= 365
Math.round(panel.getBoundingClientRect().height) >= 300
document.querySelectorAll('.about-who .stat-card').length === 0
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the image-only panel is back to the original media panel height range, has no stat cards, and has no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add styles/components.css about.html docs/plans/2026-05-25-about-image-height-restore.md
git commit -m "Restore about image panel height"
git push origin HEAD:codex/homepage-header-hero
```
