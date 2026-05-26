# Job Openings Title Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the Open roles section tag and make the jobs section title read `Job Openings`.

**Architecture:** Keep the jobs section on the existing `section-intro` and `section-title` primitives. Only change the About page content fragment, rebuild generated static HTML, verify local rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Jobs Heading Content

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Update the jobs intro markup**

Change the jobs intro in `src/pages/about.html` from:

```html
<div class="section-intro">
  <p class="section-tag section-tag--center">Open roles</p>
  <h2 id="jobs-title" class="section-title">Come build Taia with us.</h2>
  <p>We are hiring for a small number of high-impact roles. Send a short note with the role you are interested in and what you would like to build.</p>
</div>
```

to:

```html
<div class="section-intro">
  <h2 id="jobs-title" class="section-title">Job Openings</h2>
  <p>We are hiring for a small number of high-impact roles. Send a short note with the role you are interested in and what you would like to build.</p>
</div>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` is regenerated with `Job Openings` and no Open roles tag inside `#jobs`.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=job-openings-title#jobs` in the Codex browser and verify:

```js
document.querySelector('#jobs .section-tag') === null
document.querySelector('#jobs-title').textContent.trim() === 'Job Openings'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the jobs section has no tag, title reads `Job Openings`, and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-job-openings-title.md
git commit -m "Update jobs section heading"
git push origin HEAD:codex/homepage-header-hero
```
