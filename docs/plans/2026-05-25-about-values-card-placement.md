# About Values Card Placement Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move the Values section directly under the About hero and present it as a compact card.

**Architecture:** Reorder `src/pages/about.html` so Values follows the mission hero. Replace the current video/glass values treatment with a single `about-values__card` surface using existing heading, kicker, body, spacing, and color primitives.

**Tech Stack:** Static HTML partials, shared CSS, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Move and Restyle Values

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current order**

Open `src/pages/about.html`.
Expected order: hero, Who we are, What we build, Values, Jobs.

- [x] **Step 2: Move Values below hero**

Place the Values section immediately after the hero closing `</section>` and before the Who we are section.
Use this structure:

```html
<section class="about-values" aria-labelledby="values-title">
  <div class="wrap about-values__card">
    <div class="section-heading">
      <p class="kicker">Values</p>
      <h2 id="values-title" class="section-title">The principles behind the product.</h2>
    </div>
    <div class="about-values__list">
      <article class="about-values__item">
        <span>01</span>
        <div>
          <h3>Clarity over noise</h3>
          <p>Focused guidance that is easy to read and use.</p>
        </div>
      </article>
      <article class="about-values__item">
        <span>02</span>
        <div>
          <h3>Guidance without fatalism</h3>
          <p>Astrology that points people back to choice.</p>
        </div>
      </article>
      <article class="about-values__item">
        <span>03</span>
        <div>
          <h3>Built for real life</h3>
          <p>Reflection for relationships, work, and change.</p>
        </div>
      </article>
    </div>
  </div>
</section>
```

- [x] **Step 3: Add card CSS**

Add About-specific card rules in `styles/pages.css`:

```css
.about-values {
  padding: 0 0 clamp(56px, 8vw, 92px);
  background: var(--cream-header);
}

.about-values__card {
  display: grid;
  grid-template-columns: minmax(0, 0.8fr) minmax(320px, 1fr);
  gap: var(--split-gap);
  padding: clamp(28px, 4vw, 48px);
  border-radius: var(--radius-surface);
  background: var(--cream-body);
}

.about-values__list {
  display: grid;
  gap: var(--space-6);
}

.about-values__item {
  display: grid;
  grid-template-columns: 40px minmax(0, 1fr);
  gap: var(--space-5);
  padding-top: var(--space-6);
  border-top: 1px solid var(--burgundy-line);
}

.about-values__item:first-child {
  padding-top: 0;
  border-top: 0;
}
```

- [x] **Step 4: Add mobile CSS**

Update `styles/responsive.css` so the card stacks cleanly:

```css
.about-values {
  padding-bottom: var(--space-16);
}

.about-values__card {
  grid-template-columns: 1fr;
  gap: var(--space-10);
  border-radius: var(--radius-surface-mobile);
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
Expected: order is hero, Values card, Who we are, What we build, Jobs; Values renders as one card; no horizontal overflow appears.

- [x] **Step 6: Commit and push**

Stage only the About source/generated HTML, CSS, and this plan:

```bash
git add src/pages/about.html about.html styles/pages.css styles/responsive.css docs/plans/2026-05-25-about-values-card-placement.md
git commit -m "Move about values into card"
git push origin HEAD:codex/homepage-header-hero
```
