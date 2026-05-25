# Container Primitives Correction Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the failed About-page refactor by making page width, text alignment, heading scale, and surface proportions come from one central layout system instead of page-specific wrapper exceptions.

**Architecture:** Keep the static-site build flow unchanged. Replace the current ambiguous `.wrap` contract with explicit container primitives in `styles/base.css`, keep reusable layout/type/surface primitives in `styles/components.css`, and remove all page-specific container-width rules from About/Home/Legal styles. About, Home, footer, CTA, and legal pages should opt into the same named primitives so width differences are intentional and visible in markup.

**Tech Stack:** Static HTML fragments, CSS custom properties, shared CSS primitives, Node build script, local Python static server, Codex browser evidence. Research basis: MDN CSS custom properties for centralized reusable values, Material layout guidance for consistent margins/gutters, Apple typography guidance for hierarchy/legibility, and Every Layout’s composable primitive model.

---

### Task 1: Freeze Git And User-Owned Files

**Files:**
- Do not modify: `AGENTS.md`
- Do not run: `git switch`
- Do not run: `git checkout`
- Do not run: `git commit`
- Do not run: `git push`
- Do not run: `./.codex/scripts/codex-review.sh`

- [x] **Step 1: Confirm current status without mutating it**

Run:

```bash
git status --short --branch
```

Expected: worktree may be dirty, `AGENTS.md` may remain modified by the user, and no branch changes are made.

### Task 2: Define The Actual Container Contract

**Files:**
- Modify: `styles/tokens.css`
- Modify: `styles/base.css`

- [x] **Step 1: Replace ambiguous width tokens with named container tokens**

In `styles/tokens.css`, replace or augment the current container variables with this explicit contract:

```css
--container-page: 980px;
--container-wide: 1120px;
--container-readable: 640px;
--page-gutter: 64px;
--page-gutter-mobile: 32px;
```

Expected: `980px` becomes the default aligned website content width used by Home, About, shared footer, and shared CTA. `1120px` exists only for deliberate wide media. `640px` exists only for legal/readable long text.

- [x] **Step 2: Centralize container classes**

In `styles/base.css`, replace the current `.wrap` plus `.home-page main .wrap` override model with:

```css
.container,
.wrap {
  width: min(var(--container-page), calc(100% - var(--page-gutter)));
  margin: 0 auto;
}

.container-wide {
  width: min(var(--container-wide), calc(100% - var(--page-gutter)));
  margin: 0 auto;
}

.container-readable {
  width: min(var(--container-readable), calc(100% - var(--page-gutter)));
  margin: 0 auto;
}
```

Expected: plain `.wrap` is no longer wide. Existing pages that use `.wrap` automatically align to the homepage content width.

- [x] **Step 3: Remove special homepage wrapper override**

Delete this rule from `styles/base.css`:

```css
.home-page main .wrap,
.download-cta > .wrap,
.site-footer > .wrap {
  width: min(var(--content-container), calc(100% - var(--page-gutter)));
}
```

Expected: Home, About, footer, and CTA use the same default container primitive unless markup explicitly opts into `container-wide` or `container-readable`.

### Task 3: Move Legal Pages Onto The Readable Container

**Files:**
- Modify: `src/pages/privacy.html`
- Modify: `src/pages/terms.html`
- Modify: `styles/pages.css`

- [x] **Step 1: Add readable container class in legal fragments**

Change each legal root content wrapper from:

```html
<main class="legal-document">
```

to:

```html
<main class="legal-document container-readable">
```

Expected: legal pages declare the reason they are narrower in markup instead of hiding width in a page-specific CSS selector.

- [x] **Step 2: Remove legal width from page CSS**

In `styles/pages.css`, remove `width: min(640px, calc(100% - 64px))` or `width: min(var(--content-container), calc(100% - 32px))` from `.legal-document` and responsive legal rules. Keep only legal-specific padding, color, typography, and document spacing.

Expected: legal width comes exclusively from `.container-readable`.

### Task 4: Make Wide Media Explicit

**Files:**
- Modify: `src/pages/about.html`

- [x] **Step 1: Decide which About surfaces are default-width vs wide**

Use default `.wrap` for:

```html
<div class="wrap about-hero__inner">
<div class="wrap split-layout">
<div class="wrap about-jobs__inner">
```

Use `container-wide` only for the Claura-style media strip if it should intentionally breathe wider:

```html
<div class="container-wide media-strip about-team" aria-label="Taia team">
```

Expected: text aligns with Home and Legal intent. The only wide element is the team image strip, and it is obvious in markup.

- [x] **Step 2: Keep values band aligned by default**

Keep the values band inside default content width:

```html
<div class="wrap">
  <div class="visual-band">
```

Expected: the values band no longer silently follows a wider page width.

### Task 5: Delete Page-Specific Width Exceptions

**Files:**
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`

- [x] **Step 1: Remove any About wrapper width override**

Delete any rule like:

```css
.about-page .wrap {
  width: min(var(--content-container), calc(100% - var(--page-gutter)));
}
```

Expected: About width is not patched locally.

- [x] **Step 2: Update mobile container rules centrally**

In `styles/responsive.css`, replace:

```css
.wrap {
  width: min(var(--container), calc(100% - var(--page-gutter-mobile)));
}

.home-page main .wrap,
.download-cta > .wrap,
.site-footer > .wrap {
  width: min(var(--content-container), calc(100% - var(--page-gutter-mobile)));
}
```

with:

```css
.container,
.wrap {
  width: min(var(--container-page), calc(100% - var(--page-gutter-mobile)));
}

.container-wide {
  width: min(var(--container-wide), calc(100% - var(--page-gutter-mobile)));
}

.container-readable {
  width: min(var(--container-readable), calc(100% - var(--page-gutter-mobile)));
}
```

Expected: mobile gutters and widths are centralized for every page type.

### Task 6: Audit For Remaining Magic Widths

**Files:**
- Inspect: `styles/*.css`
- Inspect: `src/pages/*.html`

- [x] **Step 1: Search for hard-coded layout widths**

Run:

```bash
rg -n "980px|1120px|640px|820px|calc\\(100% - (64px|48px|32px)\\)|content-container|--container\\b|\\.about-page \\.wrap|home-page main \\.wrap|download-cta > \\.wrap|site-footer > \\.wrap" styles src
```

Expected: remaining matches are either token declarations in `styles/tokens.css`, acceptable component-internal widths such as phone-frame sizing, or lines intentionally using `container-page`, `container-wide`, or `container-readable`.

- [x] **Step 2: Fix invalid matches**

For any match that controls page alignment, replace it with one of:

```css
var(--container-page)
var(--container-wide)
var(--container-readable)
var(--page-gutter)
var(--page-gutter-mobile)
```

Expected: no page alignment width is controlled by a one-off selector.

### Task 7: Rebuild Generated HTML

**Files:**
- Generated: `about.html`
- Generated: `index.html`
- Generated: `privacy.html`
- Generated: `terms.html`
- Generated: footer-linked root HTML files

- [x] **Step 1: Run the static build**

Run:

```bash
node scripts/build-site.mjs
```

Expected: all root static HTML files build successfully.

### Task 8: Browser Evidence

**Files:**
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Serve locally**

Run only if no server is already available:

```bash
python3 -m http.server 8081 --bind 127.0.0.1
```

Expected: local site is available at `http://127.0.0.1:8081/`.

- [x] **Step 2: Verify desktop alignment**

Open these pages in the Codex browser at desktop width:

```text
http://127.0.0.1:8081/index.html
http://127.0.0.1:8081/about.html
http://127.0.0.1:8081/privacy.html
```

Expected:

```text
Home feature text left edge, About hero text left edge, About section text left edge, footer columns, and CTA content align to the same default container.
Legal copy is intentionally narrower and centered through container-readable.
No browser console errors.
```

- [x] **Step 3: Verify mobile alignment**

Set browser viewport to `390x844` and open:

```text
http://127.0.0.1:8081/about.html
http://127.0.0.1:8081/index.html
```

Expected:

```text
No horizontal overflow.
About heading scale matches homepage section scale.
Team image strip remains a compact two-column grid.
Buttons and footer links do not wrap badly.
```

- [x] **Step 4: Verify static HTTP responses**

Run:

```bash
curl -I http://127.0.0.1:8081/about.html
curl -I http://127.0.0.1:8081/jobs.html
curl -I http://127.0.0.1:8081/index.html
curl -I http://127.0.0.1:8081/privacy.html
curl -I http://127.0.0.1:8081/terms.html
```

Expected: each returns `HTTP/1.0 200 OK`.

### Task 9: Stop Before Git Actions

**Files:**
- Do not modify: `AGENTS.md`
- Do not switch branches.
- Do not run review.
- Do not commit.
- Do not push.

- [x] **Step 1: Report the result**

Final response should include:

```text
No branch switch, review, commit, or push was performed.
AGENTS.md was not touched.
List of files changed by the implementation.
Browser evidence summary with desktop/mobile coverage and console status.
```
