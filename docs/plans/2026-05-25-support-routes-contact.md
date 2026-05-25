# Support Routes To Contact Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the standalone support page and route Support footer/public URLs to the Contact page.

**Architecture:** Keep Contact as the single authored destination for contact/support requests. Delete `src/pages/support.html`, change both `/support/` and `/support.html` to static redirect shims that target `/contact/`, and keep the footer label as “Support” while its href points to `/contact/`.

**Tech Stack:** Eleventy redirect layout, static HTML meta refresh, GitHub Pages artifact build.

---

### Task 1: Consolidate Support Into Contact

**Files:**
- Delete: `src/pages/support.html`
- Create: `src/legacy/support-clean.html`
- Modify: `src/legacy/support.html`
- Modify: `src/_includes/partials/footer.njk`

- [ ] **Step 1: Delete the authored support page**

Remove `src/pages/support.html`.

Expected: Eleventy no longer emits a full `dist/support/index.html` support page.

- [ ] **Step 2: Add support redirect routes**

Create redirect shims:

```yaml
permalink: support/index.html
redirectTo: /contact/
```

and update the existing legacy support redirect:

```yaml
permalink: support.html
redirectTo: /contact/
```

Expected: `/support/` and `/support.html` both route to `/contact/`.

- [ ] **Step 3: Update footer link**

Keep the footer text `Support`, but set the href to `/contact/`.

Expected: footer label is still Support and clicking it goes to the Contact page.

### Task 2: Verify and Push

**Files:**
- Verify: generated `dist`

- [ ] **Step 1: Build**

Run:

```bash
npm run build
```

Expected: build succeeds with no full support page source.

- [ ] **Step 2: Smoke-check routes**

Serve `dist` and verify:

```bash
curl -I http://127.0.0.1:8081/contact/
curl -I http://127.0.0.1:8081/support/
curl -I http://127.0.0.1:8081/support.html
```

Expected: all return `200 OK`; support routes contain redirect markup to `/contact/`.

- [ ] **Step 3: Commit and push**

Run:

```bash
git add -A
git commit -m "Route support links to contact page"
git push origin website-v2
```
