# Homepage Header Hero Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the first homepage pass with only the header and hero sections.

**Architecture:** Recreate `index.html` from scratch as a static page using `style.css` for shared visual primitives from `design-system.html`. Copy the provided local simulator screenshot into `assets/` and render it inside a minimal black iPhone-style border.

**Tech Stack:** Static HTML, CSS, local image asset, Python static server for verification.

---

### Task 1: Homepage Shell

**Files:**
- Create: `index.html`
- Create: `style.css`
- Create: `assets/hero-app-screenshot.png`

- [ ] **Step 1: Add the local screenshot asset**

Copy `/Users/markvasilyev/Desktop/Simulator Screenshot - iPhone 17 Pro - 2026-04-22 at 15.24.14.png` to `assets/hero-app-screenshot.png`, resized for web display.

- [ ] **Step 2: Create the homepage markup**

Create a static homepage containing a left logo, right `Get the app` button, centered brand hero, subtitle, second `Get the app` button, and phone-framed screenshot.

- [ ] **Step 3: Create the stylesheet**

Use the typography, color, spacing, and button direction from `design-system.html`. Include enough shared styles for existing privacy, terms, and support pages to remain readable.

- [ ] **Step 4: Verify locally**

Run `python3 -m http.server 8080 --bind 127.0.0.1`, open `http://localhost:8080/`, inspect desktop and mobile layouts in the browser, and check that the screenshot renders inside the frame without console errors.
