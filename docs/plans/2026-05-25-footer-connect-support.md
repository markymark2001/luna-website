# Footer Connect Support Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the footer Connect group to link to Support and remove the Email link.

**Architecture:** Change the shared footer partial so every generated page receives the same footer update. Rebuild all static pages, verify the footer has `Support` under Connect and no email link in that group, then commit and push.

**Tech Stack:** Static HTML partials, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Update Connect Footer Links

**Files:**
- Modify: `src/partials/footer.html`
- Generate: `index.html`
- Generate: `about.html`
- Generate: `contact.html`
- Generate: `jobs.html`
- Generate: `privacy.html`
- Generate: `support.html`
- Generate: `terms.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Replace Connect links**

Change this Connect group in `src/partials/footer.html`:

```html
<div class="site-footer__group">
  <h2>Connect</h2>
  <a href="contact.html">Contact</a>
  <a href="mailto:mark@mediakey.io">Email</a>
</div>
```

to:

```html
<div class="site-footer__group">
  <h2>Connect</h2>
  <a href="support.html">Support</a>
</div>
```

- [x] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: all generated pages use the updated Connect group.

- [x] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/index.html
```

Open `http://127.0.0.1:8081/index.html?v=footer-connect-support` in the Codex browser and verify:

```js
const connectGroup = [...document.querySelectorAll('.site-footer__group')].find((group) => group.querySelector('h2')?.textContent.trim() === 'Connect');
[...connectGroup.querySelectorAll('a')].map((link) => [link.textContent.trim(), link.getAttribute('href')])
```

Expected: the Connect group contains only `['Support', 'support.html']`.

- [x] **Step 4: Commit and push**

Run:

```bash
git add src/partials/footer.html index.html about.html contact.html jobs.html privacy.html support.html terms.html docs/plans/2026-05-25-footer-connect-support.md
git commit -m "Update footer connect links"
git push origin HEAD:codex/homepage-header-hero
```
