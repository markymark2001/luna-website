# Reusable Phone Frame Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the one-off hero phone border with a reusable phone frame component based on the Downloads reference HTML.

**Architecture:** Keep the existing static homepage. Rename the hero-specific `.phone-frame` structure to generic `.device-frame` / `.device-frame__screen` classes, with an iPhone modifier that carries the border, radius, aspect ratio, padding, and shadow from the reference.

**Tech Stack:** Static HTML, CSS, local browser verification.

---

### Task 1: Reusable Device Frame

**Files:**
- Modify: `index.html`
- Modify: `style.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Study the reference**

Read `/Users/markvasilyev/Downloads/TAIA Landing.html` and use the `.phone` / `.phone-screen` pattern as the source for the reusable frame.

- [ ] **Step 2: Update homepage markup**

Change the hero phone wrapper to:

```html
<figure class="device-frame device-frame--iphone hero-device" aria-label="Luna app preview">
  <div class="device-frame__screen">
    <img src="assets/hero-app-screenshot.png" alt="Luna app screenshot">
  </div>
</figure>
```

- [ ] **Step 3: Update CSS**

Replace `.phone-frame` rules with reusable `.device-frame`, `.device-frame--iphone`, `.device-frame__screen`, `.device-frame img`, and `.hero-device` rules.

- [ ] **Step 4: Verify locally**

Run `python3 -m http.server 8080 --bind 127.0.0.1`, open `http://localhost:8080/`, check desktop and mobile layouts, and confirm the frame renders with no console errors.
