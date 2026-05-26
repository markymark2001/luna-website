# Clean URL Review Fixes Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Keep clean URLs canonical while preserving existing `.html` public links and fixing review-identified accessibility/metadata regressions.

**Architecture:** Add static legacy redirect pages for old `.html` paths that immediately point to the clean directory URLs. Keep clean URLs in all authored navigation, update homepage metadata to Taia, and hide the homepage header from keyboard focus until it is visually visible.

**Tech Stack:** Eleventy layoutless redirect pages, static HTML meta refresh, CSS visibility state, small browser verification.

---

### Task 1: Add Legacy Redirect Outputs

**Files:**
- Create: `src/legacy/about.html`
- Create: `src/legacy/contact.html`
- Create: `src/legacy/jobs.html`
- Create: `src/legacy/privacy.html`
- Create: `src/legacy/support.html`
- Create: `src/legacy/terms.html`
- Create: `src/legacy/design-system.html`

- [ ] **Step 1: Create redirect pages**

Each page should use `layout: false`, emit its old `.html` permalink, use a canonical link to the clean URL, and include a meta refresh plus normal link.

Expected: `npm run build` creates both `dist/privacy/index.html` and `dist/privacy.html`, with the latter redirecting to `/privacy/`.

### Task 2: Fix Accessibility and Metadata

**Files:**
- Modify: `public/styles/components.css`
- Modify: `src/pages/index.html`

- [ ] **Step 1: Hide invisible header from focus**

Add `visibility: hidden` to `.site-header` and `visibility: visible` to `.site-header.is-visible`.

Expected: invisible header controls are not focusable before the header appears.

- [ ] **Step 2: Update homepage metadata**

Set homepage front matter to Taia:

```yaml
title: Taia
description: Taia is a personal astrology app.
```

Expected: generated homepage browser title and meta description match the visible brand.

### Task 3: Verify and Push

**Files:**
- Verify: clean URL pages
- Verify: legacy redirect pages

- [ ] **Step 1: Build and smoke-check**

Run:

```bash
npm run build
curl -I http://127.0.0.1:8081/privacy/
curl -I http://127.0.0.1:8081/privacy.html
```

Expected: both paths return `200 OK`; clean URL renders full content and `.html` path contains redirect markup.

- [ ] **Step 2: Browser-check**

Open the homepage and privacy clean URL. Confirm the homepage title is Taia, no authored links contain `.html`, and no console errors appear.

- [ ] **Step 3: Commit and push**

Run:

```bash
git add -A
git commit -m "Preserve legacy page URLs"
git push origin website-v2
```
