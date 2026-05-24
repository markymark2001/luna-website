# CSS Modular Design System Refactor Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Split the current single stylesheet into clear design-system and page modules without changing the current homepage rendering.

**Architecture:** Keep the static HTML site and the existing `style.css` entrypoint. Move CSS into ordered files under `styles/`: design tokens, reset/base, shared components, homepage sections, content/legal pages, and responsive rules. `style.css` imports those modules in cascade order, which matches MDN guidance for using cascade order and custom properties deliberately.

**Tech Stack:** Static HTML, modular CSS files, CSS custom properties, local `python3 -m http.server`, Codex browser evidence.

---

### Task 1: Split CSS By Responsibility

**Files:**
- Modify: `style.css`
- Create: `styles/tokens.css`
- Create: `styles/base.css`
- Create: `styles/components.css`
- Create: `styles/home.css`
- Create: `styles/pages.css`
- Create: `styles/responsive.css`

- [ ] Move `:root` design values into `styles/tokens.css`.
- [ ] Move reset, document defaults, typography defaults, and `.wrap` into `styles/base.css`.
- [ ] Move shared components such as `.button`, `.site-header`, `.brand-logo`, `.device-frame`, `.back-link`, and content helpers into `styles/components.css`.
- [ ] Move homepage-only sections into `styles/home.css`: video hero, features, reviews, CTA, and footer.
- [ ] Move non-home page and legal page layout into `styles/pages.css`.
- [ ] Move all media queries into `styles/responsive.css`.
- [ ] Replace `style.css` content with ordered `@import` statements.

### Task 2: Reduce Local Style Drift

**Files:**
- Modify: `styles/home.css`
- Modify: `styles/components.css`

- [ ] Keep supporting text aligned around `var(--muted)`, `var(--body)`, and weight `300`.
- [ ] Keep emphasis text aligned around `var(--burgundy-deep)`.
- [ ] Avoid introducing new color or font-size literals unless they represent component-specific mechanics such as stars or masks.

### Task 3: Verify Rendering

**Files:**
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] Serve the site locally at `http://127.0.0.1:8080/`.
- [ ] Open the homepage at desktop and mobile widths in the Codex browser.
- [ ] Verify hero, feature blocks, review rows, CTA card, and footer still render with no console errors or horizontal overflow.
- [ ] Open `privacy.html` and `terms.html` to verify legal pages still receive shared CSS.
- [ ] Use `curl -I` for `/`, `/privacy.html`, and `/terms.html`.
- [ ] Commit and push only the CSS refactor and this plan.
