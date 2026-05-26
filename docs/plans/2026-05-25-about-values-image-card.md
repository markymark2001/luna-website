# About Values Image Card Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the Values block directly under the About hero from a plain card into an image-background card inspired by Claura's visual sections.

**Architecture:** Keep Values immediately after the hero and keep the existing `about-values__card` markup. Move the visual treatment into CSS by giving the card a full background image, overlay, and light-on-image content treatment while preserving responsive layout and the standard `wrap`.

**Tech Stack:** Static HTML/CSS, remote optimized image asset, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Convert Values Card To Image Background

**Files:**
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current state**

Open `src/pages/about.html` and `styles/pages.css`.
Expected: Values already appears directly after the hero, using `.about-values__card` with a flat `var(--cream-body)` background.

- [x] **Step 2: Add image-backed card CSS**

Update `.about-values__card` in `styles/pages.css` to use:

```css
.about-values__card {
  position: relative;
  min-height: clamp(420px, 44vw, 540px);
  display: grid;
  grid-template-columns: minmax(0, 0.78fr) minmax(320px, 1fr);
  align-items: center;
  gap: var(--split-gap);
  padding: clamp(28px, 4vw, 48px);
  overflow: hidden;
  border-radius: var(--radius-surface);
  background:
    linear-gradient(90deg, rgba(26, 2, 16, 0.78), rgba(26, 2, 16, 0.42) 52%, rgba(26, 2, 16, 0.12)),
    url("https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80") center / cover;
}
```

- [x] **Step 3: Set image-card text colors**

Add rules in `styles/pages.css` so `.about-values` text remains readable:

```css
.about-values__card .kicker {
  background: rgba(246, 236, 220, 0.16);
  color: var(--cream-body);
}

.about-values__card .section-title,
.about-values__item h3 {
  color: var(--cream-body);
}

.about-values__item {
  border-top-color: rgba(246, 236, 220, 0.22);
}

.about-values__item span,
.about-values__item p {
  color: rgba(246, 236, 220, 0.78);
}
```

- [x] **Step 4: Tune mobile overlay**

Update `styles/responsive.css` for `.about-values__card`:

```css
.about-values__card {
  min-height: 600px;
  background:
    linear-gradient(180deg, rgba(26, 2, 16, 0.82), rgba(26, 2, 16, 0.48)),
    url("https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1000&q=80") center / cover;
}
```

- [x] **Step 5: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: Values remains directly under the hero, renders as an image-background card, text is readable on desktop and mobile, and no horizontal overflow appears.

- [x] **Step 6: Commit and push**

Stage only the CSS and this plan:

```bash
git add styles/pages.css styles/responsive.css docs/plans/2026-05-25-about-values-image-card.md
git commit -m "Use image background for about values card"
git push origin HEAD:codex/homepage-header-hero
```
