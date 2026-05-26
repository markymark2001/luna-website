# External Hero Video Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Keep the homepage hero video hosted externally instead of bundling the MP4 in the static website artifact.

**Architecture:** Remove `public/assets/homepage-background.mp4` from the Eleventy passthrough inputs so `dist` no longer includes the large video file. Point the homepage video source at the existing R2/custom-domain URL, while leaving image and logo assets in `public/assets`.

**Tech Stack:** Eleventy, static HTML, Cloudflare R2 public/custom-domain asset URL, local generated-site verification.

---

### Task 1: Remove the Bundled Video

**Files:**
- Delete: `public/assets/homepage-background.mp4`
- Modify: `src/pages/index.html`

- [ ] **Step 1: Delete the passthrough MP4**

Run:

```bash
rm public/assets/homepage-background.mp4
```

Expected: the video is no longer copied into `dist/assets` by Eleventy.

- [ ] **Step 2: Restore the R2-hosted video URL**

In `src/pages/index.html`, set the hero video source to:

```html
<source src="https://website.lunaapp.io/homepage-background.mp4" type="video/mp4">
```

Expected: the generated homepage references the remote R2/custom-domain asset, not `assets/homepage-background.mp4`.

### Task 2: Verify the Generated Site

**Files:**
- Verify: `src/pages/index.html`
- Verify: `dist/index.html`

- [ ] **Step 1: Build**

Run:

```bash
npm run build
```

Expected: build succeeds and `dist/assets/homepage-background.mp4` does not exist.

- [ ] **Step 2: Check generated markup**

Run:

```bash
rg -n "homepage-background.mp4" src dist public
```

Expected: only source/generated HTML references `https://website.lunaapp.io/homepage-background.mp4`; no local MP4 file is present under `public` or `dist`.

- [ ] **Step 3: Browser evidence**

Serve `dist` locally and open the homepage in the Codex browser. Confirm the `<video>` source is the external URL and there are no console errors.

### Task 3: Commit and Push

**Files:**
- Stage: `public/assets/homepage-background.mp4`
- Stage: `src/pages/index.html`
- Stage: `docs/plans/2026-05-25-external-hero-video.md`

- [ ] **Step 1: Commit**

Run:

```bash
git add -A
git commit -m "Use external hero video asset"
```

- [ ] **Step 2: Push**

Run:

```bash
git push origin website-v2
```
