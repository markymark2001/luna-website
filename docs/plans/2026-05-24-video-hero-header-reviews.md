# Video Hero Header Reviews Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Adjust the video hero experiment so the header appears only after the video hero and the video fades into a dark reviews section.

**Architecture:** Move the header below the video hero and make it sticky once reached. Remove black darkening from the video overlay, use brand-colored overlays, and add a minimal dark reviews section directly after the video hero before the existing app-preview hero.

**Tech Stack:** Static HTML, CSS, local browser verification.

---

### Task 1: Video Hero Refinement

**Files:**
- Modify: `index.html`
- Modify: `style.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Move the header**

Place the site header after the video hero so it is absent from the first viewport and becomes sticky when the user scrolls past the video hero.

- [ ] **Step 2: Change the video treatment**

Remove the dark overlay and use brand-colored overlay/fade layers instead.

- [ ] **Step 3: Add dark reviews section**

Add a minimal dark reviews section immediately after the video hero.

- [ ] **Step 4: Verify locally**

Open `http://127.0.0.1:8080/`, check the initial viewport, scroll past the hero to verify the header appears, and confirm there are no console errors.
