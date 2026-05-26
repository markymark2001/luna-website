# About Hero Centered Mission Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the About hero to a centered mission layout inspired by Duolingo's About page.

**Architecture:** Keep the standardized container and typography primitives intact. Update only the About hero markup and About-specific hero composition so it uses centered kicker, centered mission headline, and one open-roles button.

**Tech Stack:** Static HTML fragment, shared CSS primitives, Node build script, local Python static server, Codex browser evidence.

---

### Task 1: Reference Pattern

**Files:**
- External reference: `https://about.duolingo.com/`

- [x] **Step 1: Capture relevant layout**

Duolingo's About page uses a centered mission section with a small "Our mission" label, a large mission statement, and a single primary action.

### Task 2: Hero Markup

**Files:**
- Modify: `src/pages/about.html`

- [x] **Step 1: Replace left-aligned hero content**

Use:

```html
<section class="about-hero about-hero--centered" aria-labelledby="about-title">
  <div class="wrap about-hero__inner">
    <p class="kicker">Our mission</p>
    <h1 id="about-title" class="page-hero-title">Help 100 million people live better lives.</h1>
    <div class="about-hero__actions">
      <a class="button primary" href="#jobs">...</a>
    </div>
  </div>
</section>
```

Expected: no support paragraph and no secondary link in the first viewport.

### Task 3: Hero Composition

**Files:**
- Modify: `styles/pages.css`

- [x] **Step 1: Center the About hero**

Add centered composition rules for `.about-hero--centered`:

```css
.about-hero--centered {
  align-items: center;
  text-align: center;
}

.about-hero--centered .about-hero__inner {
  display: grid;
  justify-items: center;
}

.about-hero--centered .page-hero-title {
  max-width: 760px;
}

.about-hero--centered .about-hero__actions {
  justify-content: center;
}
```

Expected: only layout changes; typography stays inherited from primitives.

### Task 4: Build And Verify

**Files:**
- Generated: `about.html`

- [x] **Step 1: Build**

Run:

```bash
node scripts/build-site.mjs
```

- [x] **Step 2: Browser-check About**

Open:

```text
http://127.0.0.1:8081/about.html
```

Expected: centered kicker, centered mission, centered open-roles button, no console errors.

- [x] **Step 3: Check mobile**

Set viewport to `390x844` and verify no horizontal overflow.

- [x] **Step 4: HTTP check**

Run:

```bash
curl -I http://127.0.0.1:8081/about.html
```

Expected: `HTTP/1.0 200 OK`.

### Task 5: Commit

**Files:**
- Commit: `src/pages/about.html`
- Commit: `styles/pages.css`
- Commit generated: `about.html`
- Commit: `docs/plans/2026-05-25-about-hero-centered-mission.md`

- [x] **Step 1: Commit without branch switch**

Do not touch `AGENTS.md`. Do not switch branches.
