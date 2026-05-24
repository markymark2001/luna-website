# Static HTML Shell Refactor Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove duplicated header, footer, head, and CTA shell markup across public pages while keeping GitHub Pages root-file deployment working.

**Architecture:** Add a tiny local Node build script that reads page fragments from `src/pages`, shared partials from `src/partials`, and writes complete static HTML files to the repository root. The CTA is part of the shared footer on every page. Keep the generated root `.html` files committed so GitHub Pages can still deploy from root without any server-side includes, client-side fetched components, or GitHub Actions changes.

**Tech Stack:** Static HTML, Node.js standard library only, existing CSS modules, local `python3 -m http.server`, Codex browser evidence.

---

### Task 1: Add Shared Shell Sources

**Files:**
- Create: `src/partials/head.html`
- Create: `src/partials/header.html`
- Create: `src/partials/footer.html`
- Create: `src/partials/footer-cta.html`
- Create: `src/pages/index.html`
- Create: `src/pages/privacy.html`
- Create: `src/pages/terms.html`
- Create: `src/pages/about.html`
- Create: `src/pages/contact.html`
- Create: `src/pages/jobs.html`
- Create: `src/pages/support.html`

- [x] Put document metadata placeholders in `src/partials/head.html`: `{{title}}`, `{{description}}`, and `{{stylesheetHref}}`.
- [x] Put the app header in `src/partials/header.html` once so home/legal/content pages share the same markup while CSS controls behavior.
- [x] Put footer menu and copyright in `src/partials/footer.html` once, with the CTA injected into every generated footer.
- [x] Put the dark download CTA card in `src/partials/footer-cta.html` once.
- [x] Move each page's unique main content into `src/pages/*.html` fragments.

### Task 2: Add Static Build Script

**Files:**
- Create: `scripts/build-site.mjs`
- Modify: `README.md`

- [x] Create `scripts/build-site.mjs` using only Node built-ins.
- [x] Define page metadata for all public pages: `index`, `privacy`, `terms`, `about`, `contact`, `jobs`, and `support`.
- [x] For each page, read its fragment, inject shared head/header/footer partials, and write the root `.html` file.
- [x] Preserve current public URLs: `/`, `/privacy.html`, `/terms.html`, `/about.html`, `/contact.html`, `/jobs.html`, and `/support.html`.
- [x] Document `node scripts/build-site.mjs` in `README.md`.

### Task 3: Generate And Verify

**Files:**
- Modify generated: `index.html`, `privacy.html`, `terms.html`, `about.html`, `contact.html`, `jobs.html`, `support.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] Run `node scripts/build-site.mjs`.
- [ ] Verify `git diff` shows shared generated shells instead of divergent hand-authored headers and footers.
- [ ] Serve `http://127.0.0.1:8080/`.
- [ ] Browser-check homepage desktop and mobile, including hero, reviews, CTA, and footer.
- [ ] Browser-check `privacy.html`, `terms.html`, `about.html`, `contact.html`, `jobs.html`, and `support.html`.
- [ ] Verify no console errors and no horizontal overflow.
- [ ] Run HTTP checks for `/`, `/privacy.html`, `/terms.html`, and `/support.html`.
- [ ] Commit and push only the shell refactor files plus generated HTML.
