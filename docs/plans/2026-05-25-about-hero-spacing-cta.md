# About Hero Spacing CTA Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the About hero CTA secondary and reduce the hero's vertical footprint so the page spacing matches the homepage primitives more closely.

**Architecture:** Keep About page layout on the shared `wrap`, `page-hero-title`, `section-title`, `section-band`, and `button` primitives. Add only a reusable secondary button variant and adjust the existing About hero spacing rules.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node build script, local HTTP server, Codex browser evidence.

---

### Task 1: Tighten About Hero

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm the current state**

Open `src/pages/about.html` and the About CSS rules in `styles/pages.css` and `styles/responsive.css`.
Expected: the hero CTA uses `button primary`, desktop hero min-height is `clamp(520px, 68vh, 640px)`, and mobile hero padding is `112px 0 72px`.

- [x] **Step 2: Add a reusable secondary button variant**

Add `.button.secondary` in `styles/components.css` after the primary button rules:

```css
.button.secondary {
  border-color: rgba(43, 24, 10, 0.22);
  background: transparent;
  color: var(--brown-action);
}

.button.secondary:hover {
  border-color: rgba(43, 24, 10, 0.38);
  background: rgba(43, 24, 10, 0.06);
}
```

- [x] **Step 3: Switch the About hero CTA**

Change the About hero link in `src/pages/about.html` from:

```html
<a class="button primary" href="#jobs">
```

to:

```html
<a class="button secondary" href="#jobs">
```

- [x] **Step 4: Reduce About hero spacing**

Update `styles/pages.css` to use:

```css
.about-hero {
  min-height: clamp(360px, 46vh, 440px);
}

.about-hero__inner {
  padding: clamp(76px, 8vw, 96px) 0 clamp(36px, 5vw, 56px);
}

.about-hero__actions {
  margin-top: var(--space-5);
}
```

Update `styles/responsive.css` to use:

```css
.about-hero__inner {
  padding: 76px 0 40px;
}
```

- [x] **Step 5: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
```

Serve locally and open `http://127.0.0.1:8081/about.html` in the Codex browser.
Expected: the About hero CTA is visually secondary, the hero takes less vertical space on desktop and mobile, no horizontal overflow appears, and the console has no page errors.

- [x] **Step 6: Commit**

Stage only the About, CSS, generated HTML, and plan files:

```bash
git add src/pages/about.html styles/components.css styles/pages.css styles/responsive.css about.html docs/plans/2026-05-25-about-hero-spacing-cta.md
git commit -m "Refine about hero spacing and CTA"
```
