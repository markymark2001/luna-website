# Clean Page URLs Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish public pages at extensionless directory URLs such as `/privacy/` instead of `.html` URLs.

**Architecture:** Use Eleventy permalinks that write each secondary page to `<page>/index.html`, which GitHub Pages serves at clean directory paths. Keep the homepage at root `index.html`, update all internal links to root-relative clean URLs, and update durable docs so App Store/legal references use the new URL contract.

**Tech Stack:** Eleventy permalinks, GitHub Pages static directory indexes, local generated-site verification.

---

### Task 1: Change Page Routes

**Files:**
- Modify: `src/pages/about.html`
- Modify: `src/pages/contact.html`
- Modify: `src/pages/jobs.html`
- Modify: `src/pages/privacy.html`
- Modify: `src/pages/support.html`
- Modify: `src/pages/terms.html`
- Modify: `src/design-system.html`

- [ ] **Step 1: Update page permalinks**

Set secondary page permalinks to directory index outputs:

```yaml
permalink: about/index.html
permalink: contact/index.html
permalink: jobs/index.html
permalink: privacy/index.html
permalink: support/index.html
permalink: terms/index.html
permalink: design-system/index.html
```

Expected: `npm run build` writes `dist/privacy/index.html`, `dist/terms/index.html`, and no `dist/privacy.html` or `dist/terms.html`.

### Task 2: Update Internal Links and Docs

**Files:**
- Modify: `src/_includes/partials/header.njk`
- Modify: `src/_includes/partials/footer.njk`
- Modify: `src/_includes/partials/footer-cta.njk`
- Modify: `src/pages/jobs.html`
- Modify: `src/pages/support.html`
- Modify: `src/pages/terms.html`
- Modify: `README.md`
- Modify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Update site navigation links**

Use root-relative URLs:

```html
/
/#get-the-app
/#reviews
/#download
/about/
/about/#jobs
/contact/
/support/
/privacy/
/terms/
```

Expected: no authored navigation link contains `.html`.

- [ ] **Step 2: Update durable docs**

Replace public URL examples and smoke-check paths with clean URLs:

```text
https://lunaapp.io/privacy/
https://lunaapp.io/terms/
http://localhost:8080/privacy/
http://localhost:8080/terms/
http://localhost:8080/support/
```

Expected: future App Store and verification instructions do not point agents back to `.html` URLs.

### Task 3: Verify, Commit, and Push

**Files:**
- Verify: generated `dist`
- Verify: local browser rendering

- [ ] **Step 1: Build**

Run:

```bash
npm run build
```

Expected: build succeeds and generated pages are directory indexes.

- [ ] **Step 2: Smoke-check clean URLs**

Serve `dist` and run:

```bash
curl -I http://127.0.0.1:8081/
curl -I http://127.0.0.1:8081/privacy/
curl -I http://127.0.0.1:8081/terms/
curl -I http://127.0.0.1:8081/support/
```

Expected: all return `200 OK`.

- [ ] **Step 3: Browser evidence**

Open the homepage and navigate to legal/support links in the Codex browser. Confirm the resulting browser URLs do not include `.html` and there are no console errors.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add -A
git commit -m "Use clean URLs for public pages"
git push origin website-v2
```
