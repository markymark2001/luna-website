# DRY Template Refactor Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove avoidable template duplication and dead support-page remnants while preserving the current generated site behavior.

**Architecture:** Use Eleventy global data files for repeated structured content: redirect routes, homepage feature blocks/review cards, and open roles. Render those datasets through Nunjucks loops in the existing page templates. Keep public URLs unchanged, keep `/support/` plus `/support.html` as redirect shims to `/contact/`, and remove stale CSS hooks that no source template still uses.

**Tech Stack:** Eleventy global data, Nunjucks loops, static redirect layout, local generated-site verification.

---

### Task 1: Consolidate Redirect Shims

**Files:**
- Create: `src/_data/redirects.js`
- Create: `src/legacy/redirects.njk`
- Delete: `src/legacy/about.html`
- Delete: `src/legacy/contact.html`
- Delete: `src/legacy/design-system.html`
- Delete: `src/legacy/jobs.html`
- Delete: `src/legacy/privacy.html`
- Delete: `src/legacy/support-clean.html`
- Delete: `src/legacy/support.html`
- Delete: `src/legacy/terms.html`

- [x] **Step 1: Move redirect route data into one file**

Create a redirects data file with `{ from, to }` objects for all legacy aliases:

```js
export default [
  { from: "about.html", to: "/about/" },
  { from: "contact.html", to: "/contact/" },
  { from: "design-system.html", to: "/design-system/" },
  { from: "jobs.html", to: "/jobs/" },
  { from: "privacy.html", to: "/privacy/" },
  { from: "support/index.html", to: "/contact/" },
  { from: "support.html", to: "/contact/" },
  { from: "terms.html", to: "/terms/" }
];
```

- [x] **Step 2: Generate redirects from one template**

Create a paginated redirect template that uses `layouts/redirect.njk`, with `permalink` read from `redirect.from` and the shared redirect layout reading `redirect.to`.

Expected: `npm run build` still writes all redirect shim outputs.

### Task 2: Make Homepage Repeated Sections Data-Driven

**Files:**
- Create: `src/_data/home.js`
- Modify: `src/pages/index.html`

- [x] **Step 1: Move feature blocks into data**

Create a `features` array with title, copy, and reverse flag.

Expected: `src/pages/index.html` renders the four feature blocks by looping over `home.features`.

- [x] **Step 2: Move review cards into data**

Create `reviewRows`, each with `reverse` and `reviews`. Keep one source review group per row and let `public/scripts/home.js` clone extra groups for marquee length.

Expected: generated homepage keeps the same visible reviews while source no longer repeats every group twice.

### Task 3: Make Jobs Rows Data-Driven

**Files:**
- Create: `src/_data/jobs.js`
- Modify: `src/pages/about.html`

- [x] **Step 1: Move open roles into data**

Create role data with title and `mailto:` subject.

Expected: About page Jobs section loops through `jobs.openRoles`, preserving role titles and Apply links.

### Task 4: Verify and Push

**Files:**
- Verify: generated `dist`

- [x] **Step 1: Build**

Run:

```bash
npm run build
```

Expected: build succeeds with the same public clean URLs and redirect shims.

- [x] **Step 2: Smoke-check critical paths**

Serve `dist` and verify:

```bash
curl -I http://127.0.0.1:8081/
curl -I http://127.0.0.1:8081/privacy/
curl -I http://127.0.0.1:8081/privacy.html
curl -I http://127.0.0.1:8081/support/
curl -I http://127.0.0.1:8081/contact/
```

Expected: all return `200 OK`.

- [x] **Step 3: Browser-check**

Open the homepage, About Jobs section, Contact page, and support redirect path in the Codex browser. Confirm no console errors and no visible behavior regression.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add -A
git commit -m "DRY repeated Eleventy templates"
git push origin website-v2
```
