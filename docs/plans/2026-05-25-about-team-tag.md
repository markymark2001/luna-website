# About Team Tag Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the About Who section tag from `Who we are` to `The team`.

**Architecture:** Keep the existing `section-tag` primitive and section layout unchanged. Replace only the tag text in the About source fragment, rebuild generated HTML, verify rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Update Team Section Tag

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace tag text**

Change this tag in `src/pages/about.html`:

```html
<p class="section-tag">Who we are</p>
```

to:

```html
<p class="section-tag">The team</p>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` contains `<p class="section-tag">The team</p>` in the About stats/team section.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-team-tag` in the Codex browser and verify:

```js
document.querySelector('.about-who .section-tag').textContent.trim() === 'The team'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the tag renders as `The team` and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-team-tag.md
git commit -m "Update about team tag"
git push origin HEAD:codex/homepage-header-hero
```
