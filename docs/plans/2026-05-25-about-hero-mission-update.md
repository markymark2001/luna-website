# About Hero Mission Update Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the About hero with a Claura-inspired mission opening using the approved Taia mission: "Help 100 million people live better lives."

**Architecture:** Keep the standardized layout and typography primitives intact. Change only the About hero content and minimal hero composition needed to preserve the existing Home-derived typography scale, container alignment, header shell, and footer/content widths.

**Tech Stack:** Static HTML fragment, shared CSS primitives, Node build script, local Python static server, Codex browser evidence.

---

### Task 1: Research Reference

**Files:**
- Read external: `https://claura.framer.ai/about`

- [x] **Step 1: Record relevant reference pattern**

Claura's About hero uses a small kicker, one direct mission headline, and a short explanatory paragraph. It avoids extra cards or statistics in the first viewport.

### Task 2: Update Hero Content

**Files:**
- Modify: `src/pages/about.html`

- [x] **Step 1: Replace About hero headline**

Use the exact mission:

```html
<h1 id="about-title" class="page-hero-title">Help 100 million people live better lives.</h1>
```

Expected: the About hero is mission-first and concise.

- [x] **Step 2: Replace supporting copy**

Use a short support line that fits the mission:

```html
<p>Taia turns astrology into practical guidance for reflection, relationships, timing, and the decisions people carry through everyday life.</p>
```

Expected: copy explains what Taia does without competing with the mission headline.

### Task 3: Preserve Standardized Typography

**Files:**
- Inspect: `styles/components.css`
- Inspect: `styles/pages.css`

- [x] **Step 1: Keep About hero typography on Home-derived primitives**

Do not add new About-specific hero font sizes, weights, colors, or tracking. `.page-hero-title` must continue to match `.feature-copy h2` for computed size, color, line-height, letter-spacing, and weight.

### Task 4: Build And Verify

**Files:**
- Generated: `about.html`

- [ ] **Step 1: Rebuild static files**

Run:

```bash
node scripts/build-site.mjs
```

Expected: generated root files rebuild successfully.

- [ ] **Step 2: Browser-check About desktop and mobile**

Open:

```text
http://127.0.0.1:8081/about.html
```

Expected:

```text
Desktop hero uses the new mission.
Mobile hero has no horizontal overflow.
Browser console has no errors.
```

- [ ] **Step 3: Confirm computed typography still matches Home**

Compare `.feature-copy h2` on Home with `.page-hero-title` on About.

Expected:

```text
font-size, font-weight, color, line-height, and letter-spacing match.
```

- [ ] **Step 4: Static HTTP check**

Run:

```bash
curl -I http://127.0.0.1:8081/about.html
```

Expected: `HTTP/1.0 200 OK`.

### Task 5: Commit

**Files:**
- Commit: `src/pages/about.html`
- Commit generated: `about.html`
- Commit: `docs/plans/2026-05-25-about-hero-mission-update.md`

- [ ] **Step 1: Commit current detached checkout**

Do not switch branches. Do not touch `AGENTS.md`. Commit only About hero and plan changes.
