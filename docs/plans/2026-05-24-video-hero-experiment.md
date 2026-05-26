# Video Hero Experiment Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a new video-first homepage hero above the current app-preview hero for visual comparison.

**Architecture:** Copy the Luna app homepage background video into the website assets and introduce a new static hero section before the existing hero. The new section uses an autoplaying, muted, looped background video with centered Luna title, subtitle, and CTA only.

**Tech Stack:** Static HTML, CSS, local MP4 asset, browser verification.

---

### Task 1: Add Video Hero

**Files:**
- Create: `assets/homepage-background.mp4`
- Modify: `index.html`
- Modify: `style.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Copy the Luna background video**

Copy `/Users/markvasilyev/luna/assets/videos/background.mp4` to `assets/homepage-background.mp4`.

- [ ] **Step 2: Add the video hero markup**

Insert a new section above the current app-preview hero:

```html
<section class="video-hero" aria-labelledby="video-hero-title">
  <video class="video-hero__media" autoplay muted loop playsinline preload="metadata" aria-hidden="true">
    <source src="assets/homepage-background.mp4" type="video/mp4">
  </video>
  <div class="video-hero__overlay" aria-hidden="true"></div>
  <div class="wrap video-hero__content">
    <h1 id="video-hero-title" class="hero-logo">Luna</h1>
    <p class="hero-subtitle">Personal astrology for clearer days.</p>
    <a class="button primary hero-button" href="#get-the-app">...</a>
  </div>
</section>
```

- [ ] **Step 3: Add CSS**

Style the section as a centered full-width hero with `object-fit: cover`, readable overlay, centered text, and responsive height.

- [ ] **Step 4: Verify locally**

Open `http://127.0.0.1:8080/` in the browser, verify the video hero appears above the existing hero, the video element has loaded dimensions, and there are no console errors.
