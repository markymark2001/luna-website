# About Claura Who Section Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the current About middle sections with one Claura-style Who we are section followed by Jobs.

**Architecture:** Keep the mission hero and Jobs section. Remove the separate Values, team-image strip, and What we build sections from `src/pages/about.html`; replace them with one section using a top pill, two-column intro, large rounded image panel, and translucent stat cards.

**Tech Stack:** Static HTML partials, shared CSS primitives, remote visual asset, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Replace About Middle Sections

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Modify: `styles/tokens.css`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Inspect reference and current state**

Open `https://claura.framer.ai/about` and inspect the second section.
Expected reference: pill label, title on the left, paragraph on the right, large rounded image below, three translucent metric cards over the image, then a jobs CTA card.

- [x] **Step 2: Replace About middle markup**

In `src/pages/about.html`, remove the current Values, Who we are team strip, and What we build sections.
Insert one new section after the hero:

```html
<section class="section-band section-band--alt about-who" aria-labelledby="who-we-are-title">
  <div class="wrap about-who__inner">
    <div class="about-who__intro">
      <div>
        <p class="kicker">Who we are</p>
        <h2 id="who-we-are-title" class="section-title">A small team building personal cosmic guidance for real life.</h2>
      </div>
      <p class="about-who__copy">We are building Taia for people who want insight without noise. Our work combines thoughtful product design, conversational guidance, and astrological context so reflection feels simple enough to return to every week.</p>
    </div>
    <div class="about-who__visual" aria-label="Taia company metrics">
      <img src="https://framerusercontent.com/images/3jSoIlDJyMfLx6JTWfHwuwwhjSw.png?width=2144&amp;height=730" alt="">
      <div class="about-who__metrics">
        <article class="about-who__metric">
          <strong>4</strong>
          <span>Team size</span>
        </article>
        <article class="about-who__metric">
          <strong>28%</strong>
          <span>Monthly growth</span>
        </article>
        <article class="about-who__metric">
          <strong>120+</strong>
          <span>Content pieces per month</span>
        </article>
      </div>
    </div>
  </div>
</section>
```

- [x] **Step 3: Replace removed CSS with Who section CSS**

In `styles/pages.css`, remove the old `.about-values`, `.about-copy`, `.about-team`, and `.about-build` rules.
Add:

```css
.about-who__inner {
  display: grid;
  gap: var(--space-12);
}

.about-who__intro {
  display: grid;
  grid-template-columns: minmax(0, 0.95fr) minmax(320px, 0.72fr);
  gap: var(--split-gap);
  align-items: start;
}

.about-who__copy {
  margin: 0;
  color: var(--muted);
  font-size: var(--body);
  font-weight: 300;
  line-height: 1.5;
}
```

- [x] **Step 4: Add image metric CSS**

In `styles/pages.css`, add:

```css
.about-who__visual {
  position: relative;
  min-height: clamp(300px, 32vw, 365px);
  display: grid;
  align-items: center;
  overflow: hidden;
  border-radius: var(--radius-surface);
  background: var(--cream-section);
}

.about-who__visual img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.about-who__metrics {
  position: relative;
  z-index: 1;
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: var(--space-4);
  padding: clamp(40px, 5vw, 64px);
}

.about-who__metric {
  min-height: 164px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--space-6);
  border: 1px solid rgba(246, 236, 220, 0.2);
  border-radius: var(--radius-surface);
  background: rgba(246, 236, 220, 0.32);
  backdrop-filter: blur(14px);
  text-align: center;
}
```

- [x] **Step 5: Add mobile CSS**

In `styles/responsive.css`, remove old About Values/team/build responsive rules and add:

```css
.about-who__intro {
  grid-template-columns: 1fr;
  gap: var(--space-8);
}

.about-who__metrics {
  grid-template-columns: 1fr;
  padding: var(--space-5);
}

.about-who__metric {
  min-height: 132px;
  border-radius: var(--radius-surface-mobile);
}
```

- [x] **Step 6: Build and verify**

Remove the now-unused `.media-*`, `.visual-band*`, and `.glass-*` component rules from `styles/components.css`, then remove the unused `--media-grid-gap` and `--card-heading` tokens from `styles/tokens.css`.

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: order is hero, Who we are section, Jobs; the image panel renders; stat cards are readable; old Values/team/What sections are gone; no horizontal overflow appears.

- [x] **Step 7: Commit and push**

Stage only the About source/generated HTML, CSS, and this plan:

```bash
git add src/pages/about.html about.html styles/pages.css styles/responsive.css docs/plans/2026-05-25-about-claura-who-section.md
git commit -m "Replace about middle with who metrics section"
git push origin HEAD:codex/homepage-header-hero
```
