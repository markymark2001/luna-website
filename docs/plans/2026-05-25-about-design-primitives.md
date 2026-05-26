# About Design Primitives Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the About page so its remaining section layout, media panel, and metric cards use shared design-system primitives instead of page-specific CSS.

**Architecture:** Keep page identity classes only for page-level spacing hooks, and move reusable visual/layout contracts into `styles/components.css` with responsive behavior in `styles/responsive.css`. Update `src/pages/about.html` to compose those primitives directly, then rebuild generated HTML.

**Tech Stack:** Static HTML partials, CSS tokens/components, `node scripts/build-site.mjs`, local Python HTTP server, Codex browser runtime evidence.

---

### Task 1: Replace About-Specific Middle Section Classes

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Generate: `about.html`

- [ ] **Step 1: Add shared primitives**

Move the reusable split intro and media-metric panel styles into `styles/components.css`:

```css
.split-intro {
  display: grid;
  grid-template-columns: minmax(0, 0.95fr) minmax(320px, 0.72fr);
  gap: var(--split-gap);
  align-items: start;
}

.split-intro__copy {
  margin: 0;
  color: var(--muted);
  font-size: var(--body);
  font-weight: 300;
  line-height: 1.5;
}

.media-stat-panel {
  position: relative;
  min-height: clamp(300px, 32vw, 365px);
  display: grid;
  align-items: center;
  overflow: hidden;
  border-radius: var(--radius-surface);
  background: var(--cream-section);
}

.media-stat-panel__image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.media-stat-panel__grid {
  position: relative;
  z-index: 1;
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: var(--space-4);
  padding: clamp(40px, 5vw, 64px);
}

.stat-card {
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

.stat-card__value {
  color: rgba(246, 236, 220, 0.9);
  font-size: clamp(42px, 5vw, 64px);
  font-weight: 300;
  line-height: 1;
  letter-spacing: var(--tracking-display);
}

.stat-card__label {
  margin-top: var(--space-4);
  color: rgba(246, 236, 220, 0.9);
  font-size: var(--body);
  font-weight: 300;
  line-height: 1.35;
}
```

- [ ] **Step 2: Use primitives in About markup**

Change the Who section in `src/pages/about.html` from `about-who__intro`, `about-who__copy`, `about-who__visual`, `about-who__metrics`, and `about-who__metric` to the new primitive classes while keeping `about-who` and `about-who__inner` only for page section identity and vertical composition.

- [ ] **Step 3: Remove dead page-specific styles**

Delete the old one-off middle-section styles from `styles/pages.css`. Keep only page-specific section wrappers such as `.about-who__inner`, `.about-jobs`, and `.about-jobs__inner`.

- [ ] **Step 4: Move mobile behavior to primitives**

Replace responsive selectors for `about-who__intro`, `about-who__metrics`, `about-who__metric`, and `about-who__visual` with `split-intro`, `media-stat-panel__grid`, `stat-card`, and `media-stat-panel` selectors.

- [ ] **Step 5: Build and inspect**

Run:

```bash
node scripts/build-site.mjs
git diff --check
```

Expected: generated `about.html` matches source changes and no whitespace errors.

- [ ] **Step 6: Runtime evidence**

Open `http://127.0.0.1:8081/about.html?v=about-design-primitives` in the Codex browser at desktop and mobile widths. Verify:

```js
Boolean(document.querySelector('.split-intro'))
Boolean(document.querySelector('.media-stat-panel'))
document.querySelectorAll('.stat-card').length === 3
!document.querySelector('.about-who__intro, .about-who__copy, .about-who__visual, .about-who__metrics, .about-who__metric')
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: About renders with the same visible layout, no obsolete page-specific component classes, and no horizontal overflow.

- [ ] **Step 7: Commit and push**

Stage only implementation files and the plan, not `AGENTS.md`:

```bash
git add src/pages/about.html about.html styles/components.css styles/pages.css styles/responsive.css docs/plans/2026-05-25-about-design-primitives.md
git commit -m "Extract about design primitives"
git push origin HEAD:codex/homepage-header-hero
```
