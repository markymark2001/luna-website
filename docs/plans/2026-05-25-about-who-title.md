# About Who Title Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the Who section title to `Bringing Taia to life.`

**Architecture:** Keep the existing `section-tag`, `section-title`, and split intro primitives unchanged. Only replace the heading copy in the About page source, rebuild generated HTML, verify rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Update Who Section Heading

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace heading text**

Change this heading in `src/pages/about.html`:

```html
<h2 id="who-we-are-title" class="section-title">A small team building personal cosmic guidance for real life.</h2>
```

to:

```html
<h2 id="who-we-are-title" class="section-title">Bringing Taia to life.</h2>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` contains `Bringing Taia to life.` and no longer contains the old Who section title.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-who-title` in the Codex browser and verify:

```js
document.querySelector('#who-we-are-title').textContent.trim() === 'Bringing Taia to life.'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the Who section heading renders with the new copy and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-who-title.md
git commit -m "Update about who title"
git push origin HEAD:codex/homepage-header-hero
```
