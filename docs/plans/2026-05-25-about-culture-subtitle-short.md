# About Culture Subtitle Short Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Shorten the Who section subtitle to the two approved culture sentences.

**Architecture:** Keep the existing split intro and typography primitives unchanged. Replace only the paragraph copy in the About source fragment, rebuild generated HTML, verify rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Shorten Culture Subtitle

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace subtitle text**

Change the Who section subtitle in `src/pages/about.html` to exactly:

```html
<p class="split-intro__copy">In our culture, everyone is responsible and has full ownership of their work. It's a fast-paced environment with high standards, and we're all passionate about the work we do.</p>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` contains the shortened subtitle and no longer contains `no boss-and-employee dynamic`.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-culture-subtitle-short` in the Codex browser and verify:

```js
const copy = document.querySelector('.split-intro__copy').textContent.trim();
copy === "In our culture, everyone is responsible and has full ownership of their work. It's a fast-paced environment with high standards, and we're all passionate about the work we do."
!copy.includes('no boss-and-employee dynamic')
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the shortened paragraph renders in the Who section and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-culture-subtitle.md docs/plans/2026-05-25-about-culture-subtitle-short.md
git commit -m "Shorten about culture subtitle"
git push origin HEAD:codex/homepage-header-hero
```
