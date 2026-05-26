# Kicker Pill Tags Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the shared section kicker labels into compact pill-shaped tags inspired by Claura while using Taia's existing colors, font scale, and spacing tokens.

**Architecture:** Update the shared `.kicker` primitive in `styles/components.css` so About labels inherit the new tag treatment without one-off About-only CSS. Rebuild generated static HTML and verify the About page in-browser.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Shared Kicker Tag Primitive

**Files:**
- Modify: `styles/components.css`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current primitive**

Open `styles/components.css` and find:

```css
.kicker {
  margin: 0 0 var(--space-4);
  color: var(--burgundy-soft);
  font-size: var(--small);
  font-weight: 500;
  line-height: 1;
  text-transform: uppercase;
}
```

Expected: section labels render as plain uppercase text with no pill background.

- [x] **Step 2: Implement pill tag styling**

Replace the `.kicker` rule in `styles/components.css` with:

```css
.kicker {
  display: inline-flex;
  align-items: center;
  width: fit-content;
  margin: 0 0 var(--space-4);
  padding: 7px 13px;
  border: 1px solid rgba(90, 22, 38, 0.16);
  border-radius: var(--radius-pill);
  background: rgba(90, 22, 38, 0.07);
  color: var(--burgundy);
  font-size: 12px;
  font-weight: 500;
  line-height: 1;
  text-transform: uppercase;
}
```

- [x] **Step 3: Preserve centered hero alignment**

Verify `.about-hero--centered .about-hero__inner` still uses `justify-items: center` in `styles/pages.css`.
Expected: the hero tag remains centered because `.kicker` uses `width: fit-content`.

- [x] **Step 4: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: About section tags render as compact rounded pills, text alignment remains correct, no horizontal overflow appears, and the page has no console errors.

- [x] **Step 5: Commit and push**

Stage only the shared CSS, generated HTML, and this plan:

```bash
git add styles/components.css about.html docs/plans/2026-05-25-kicker-pill-tags.md
git commit -m "Style section kickers as pill tags"
git push origin HEAD:codex/homepage-header-hero
```
