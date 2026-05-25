# About Page Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a concise About page that merges company and jobs content while preserving public footer navigation.

**Architecture:** Keep the site static and source-driven: edit `src/pages/about.html`, `src/pages/jobs.html`, `src/partials/footer.html`, and shared style modules, then regenerate root HTML with `scripts/build-site.mjs`. Standardize page width, heading scale, section rhythm, media radius, and panel thickness through shared tokens and components so About and homepage surfaces use the same proportions.

**Tech Stack:** Static HTML fragments, CSS custom properties, Node build script, local Python static server, Codex browser runtime evidence.

---

### Task 1: Source Markup

**Files:**
- Modify: `src/pages/about.html`
- Modify: `src/pages/jobs.html`
- Modify: `src/partials/footer.html`

- [ ] Replace the minimal About fragment with semantic sections for mission, who we are, what we build, values, and jobs.
- [ ] Add the Claura-style team image strip inside the Who we are section instead of a separate team section.
- [ ] Keep the Jobs section anchor as `id="jobs"` for direct navigation.
- [ ] Change the Jobs footer link to `about.html#jobs`.
- [ ] Keep `src/pages/jobs.html` as a compatibility page that directs people to `about.html#jobs`.

### Task 2: Page Styling

**Files:**
- Modify: `styles/tokens.css`
- Modify: `styles/base.css`
- Modify: `styles/components.css`
- Modify: `styles/home.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`

- [ ] Add shared tokens for gutters, section padding, section gaps, layout gaps, surface radii, and heading scales.
- [ ] Add reusable components for section bands, section headings, split layouts, surface panels, media cards, visual bands, and glass panels.
- [ ] Move homepage section spacing/headline/radius rules onto those shared tokens.
- [ ] Add scoped About page classes that reuse existing color, spacing, radius, and type tokens.
- [ ] Style the team strip as rounded image cards with bottom text overlays.
- [ ] Style values as a large visual media band with translucent panels.
- [ ] Use existing `.button.primary` for the Jobs email CTA.
- [ ] Keep content responsive without horizontal overflow at mobile widths.

### Task 3: Build And Verify

**Files:**
- Generated: `about.html`
- Generated: `jobs.html`
- Generated: all root HTML files touched by the shared footer
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] Run `node scripts/build-site.mjs`.
- [ ] Inspect the generated `about.html` and `jobs.html`.
- [ ] Serve locally with `python3 -m http.server 8080 --bind 127.0.0.1`.
- [ ] Use the Codex browser to check `about.html` desktop and mobile, `about.html#jobs`, and `jobs.html`.
- [ ] Check browser console logs for affected pages.
- [ ] Run `curl -I` for `about.html` and `jobs.html`.

### Task 4: Publish

**Files:**
- Commit all changed source, generated HTML, spec, and plan files.

- [ ] Review `git diff`.
- [ ] Create a `codex/` branch if still detached.
- [ ] Commit the implementation.
- [ ] Verify the branch has no merge conflicts with `main`.
- [ ] Push the branch and open a non-draft PR into `main`.
