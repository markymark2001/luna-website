# Job Remote Full-Time Metadata Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Show `Remote · Full-time` under each job title and remove the separate right-side `Remote` label.

**Architecture:** Keep the existing row and button primitives. Treat job location/employment type as the row subtitle, and keep `row-item__actions` focused on the Apply button only.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Replace Job Team Labels With Metadata

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Update each job row**

Change each job row in `src/pages/about.html` to use this content pattern:

```html
<span class="row-item__content">
  <strong class="row-item__title">Founding Product Designer</strong>
  <small class="row-item__subtitle">Remote · Full-time</small>
</span>
<span class="row-item__actions">
  <a class="button secondary" href="mailto:mark@mediakey.io?subject=Founding%20Product%20Designer">
    <span>Apply</span>
    <span aria-hidden="true">Apply</span>
  </a>
</span>
```

Repeat this for all three roles while preserving each role title and `mailto:` subject.

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` contains `Remote · Full-time` three times and no `row-item__meta` inside `#jobs`.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=job-remote-full-time#jobs` in the Codex browser and verify:

```js
document.querySelectorAll('#jobs .row-item__subtitle').length === 3
[...document.querySelectorAll('#jobs .row-item__subtitle')].every((node) => node.textContent.trim() === 'Remote · Full-time')
document.querySelectorAll('#jobs .row-item__meta').length === 0
document.querySelectorAll('#jobs .button.secondary').length === 3
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: all three rows show `Remote · Full-time`, no separate Remote meta remains, all Apply buttons remain, and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-job-remote-full-time-meta.md
git commit -m "Update job row metadata"
git push origin HEAD:codex/homepage-header-hero
```
