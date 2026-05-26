# About Page Design System Refactor Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Standardize About-page and homepage proportions through shared layout, typography, and surface primitives.

**Architecture:** Keep the static-site build flow unchanged. Move reusable layout decisions into `styles/tokens.css`, `styles/base.css`, and `styles/components.css`; keep `styles/pages.css` for About-specific composition only; keep homepage sections in `styles/home.css` but point shared sizing/radius/spacing values at tokens. Regenerate root HTML with `scripts/build-site.mjs`.

**Tech Stack:** Static HTML fragments, CSS custom properties, shared CSS component primitives, Node static build script, local Python static server, Codex browser evidence.

---

### Task 1: Preserve User-Owned Work

**Files:**
- Do not modify: `AGENTS.md`

- [x] **Step 1: Treat `AGENTS.md` as user-owned**

Leave the existing `AGENTS.md` diff untouched. Do not restore, stage, or edit it.

### Task 2: Shared Proportion Tokens

**Files:**
- Modify: `styles/tokens.css`
- Modify: `styles/base.css`

- [x] **Step 1: Add shared layout tokens**

Add tokens for gutters, section rhythm, layout gaps, surface radii, and heading scales:

```css
--radius-surface: 24px;
--radius-surface-mobile: 18px;
--page-gutter: 64px;
--page-gutter-mobile: 32px;
--section-padding-block: 92px 0 112px;
--section-padding-block-mobile: 72px 0 88px;
--section-stack-gap: 112px;
--section-stack-gap-mobile: 76px;
--layout-gap: clamp(48px, 8vw, 112px);
--split-gap: clamp(40px, 7vw, 96px);
--hero-page-heading: clamp(46px, 6.4vw, 78px);
--hero-page-heading-mobile: clamp(40px, 11vw, 50px);
--section-heading: clamp(34px, 4vw, 56px);
--section-heading-mobile: clamp(32px, 8.8vw, 44px);
```

- [x] **Step 2: Use gutter tokens in containers**

Update `.wrap`, homepage main wrappers, CTA wrappers, and footer wrappers to use `--page-gutter` instead of hard-coded `64px`.

### Task 3: Shared Components

**Files:**
- Modify: `styles/components.css`

- [x] **Step 1: Add reusable primitives**

Add reusable classes for:

```text
section-band
section-heading
kicker
section-title
page-hero-title
body-copy
split-layout
surface-panel
media-strip
media-card
visual-band
glass-grid
glass-item
```

Expected: future static pages can use the same page widths, heading weights, radii, and section spacing without copying About-specific CSS.

### Task 4: About Page Wiring

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/pages.css`

- [x] **Step 1: Replace local About-only styling hooks with primitives**

Use shared classes directly in the About fragment:

```html
<section class="section-band section-band--alt">
<h2 class="section-title">
<div class="split-layout">
<div class="media-strip">
<article class="media-card">
<div class="visual-band">
<div class="glass-grid">
<article class="glass-item">
```

Expected: About keeps its content and Claura-inspired image strip, but its proportions come from the shared system.

- [x] **Step 2: Keep `styles/pages.css` page-specific**

Remove duplicated About definitions for headings, cards, values panels, and visual bands. Keep only About-specific hero spacing, copy grouping, product principle panel layout, and jobs callout composition.

### Task 5: Homepage Wiring

**Files:**
- Modify: `styles/home.css`
- Modify: `styles/responsive.css`

- [x] **Step 1: Use shared tokens in homepage sections**

Point feature/review section padding, feature stack gaps, feature layout gaps, section heading sizes, review-card radius, and download CTA radius at the shared tokens.

- [x] **Step 2: Use shared mobile tokens**

Update responsive rules to use `--page-gutter-mobile`, `--section-padding-block-mobile`, shared `.split-layout`, `.section-title`, `.media-strip`, `.media-card`, `.visual-band`, `.glass-grid`, and `.glass-item`.

### Task 6: Build And Verify

**Files:**
- Generated: `about.html`
- Generated: `index.html`
- Generated: footer-linked root HTML files
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Build generated files**

Run:

```bash
node scripts/build-site.mjs
```

Expected: root HTML files rebuild without errors.

- [x] **Step 2: Browser-check changed surfaces**

Serve locally on the available port:

```bash
python3 -m http.server 8081 --bind 127.0.0.1
```

Verify:

```text
http://127.0.0.1:8081/about.html
http://127.0.0.1:8081/index.html
```

Expected: desktop and mobile About render with no horizontal overflow, homepage feature section still matches the established proportions, and browser console has no errors.

- [x] **Step 3: Static HTTP checks**

Run:

```bash
curl -I http://127.0.0.1:8081/about.html
curl -I http://127.0.0.1:8081/jobs.html
curl -I http://127.0.0.1:8081/index.html
```

Expected: each returns `HTTP/1.0 200 OK`.

### Task 7: Stop Before Git Actions

**Files:**
- Do not create branches.
- Do not commit.
- Do not push.
- Do not run review.

- [x] **Step 1: Leave git actions to the user**

Because the user explicitly said not to switch branches and objected to review, stop after implementation and verification.
