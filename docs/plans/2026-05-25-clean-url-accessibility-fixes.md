# Clean URL Accessibility Fixes Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Resolve accessibility issues found after the clean URL refactor without changing the clean URL contract.

**Architecture:** Keep the external hero video, but remove markup-level autoplay and let homepage JavaScript start it only when the user has not requested reduced motion. Update remaining homepage accessible names from Luna to Taia so assistive technology and fallback text match the visible brand.

**Tech Stack:** Static HTML, small homepage JavaScript, `prefers-reduced-motion`.

---

### Task 1: Respect Reduced Motion

**Files:**
- Modify: `src/pages/index.html`
- Modify: `public/scripts/home.js`

- [ ] **Step 1: Remove video autoplay from markup**

Remove the `autoplay` attribute from the hero video.

Expected: the video does not start before JavaScript checks reduced-motion preference.

- [ ] **Step 2: Start video only when motion is allowed**

In `public/scripts/home.js`, query `.video-hero__media` and `matchMedia("(prefers-reduced-motion: reduce)")`. If reduced motion is not requested, call `video.play()`; otherwise pause the video.

Expected: users with reduced motion do not receive a looping autoplay background video.

### Task 2: Update Accessible Labels

**Files:**
- Modify: `src/pages/index.html`

- [ ] **Step 1: Replace stale Luna labels**

Change homepage feature section and screenshot labels from Luna to Taia.

Expected: generated homepage accessibility text matches the Taia brand.

### Task 3: Verify and Push

**Files:**
- Verify: generated homepage

- [ ] **Step 1: Build and inspect**

Run:

```bash
npm run build
rg -n "Luna app|Luna features|autoplay" dist/index.html
```

Expected: no stale Luna labels and no `autoplay` attribute on the hero video.

- [ ] **Step 2: Commit and push**

Run:

```bash
git add -A
git commit -m "Use clean URLs for public pages"
git push origin website-v2
```
