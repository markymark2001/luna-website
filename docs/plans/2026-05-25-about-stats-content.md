# About Stats Content Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the About stats cards to show team size 20, 2x monthly revenue growth, and 2200 social media posts per month.

**Architecture:** Keep the existing `stat-card` primitive and image panel layout. Replace only the stat values and labels in the About source fragment, rebuild generated HTML, verify desktop/mobile rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Update Stats Copy

**Files:**
- Modify: `src/pages/about.html`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace stat values and labels**

Change the three stat cards in `src/pages/about.html` to:

```html
<article class="stat-card">
  <strong class="stat-card__value">20</strong>
  <span class="stat-card__label">Team size</span>
</article>
<article class="stat-card">
  <strong class="stat-card__value">2x</strong>
  <span class="stat-card__label">Monthly revenue growth</span>
</article>
<article class="stat-card">
  <strong class="stat-card__value">2200</strong>
  <span class="stat-card__label">Social media posts per month</span>
</article>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `about.html` contains the new stat values and labels, and no longer contains `4`, `28%`, or `120+` inside the stats panel.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html?v=about-stats-content` in the Codex browser and verify:

```js
const values = [...document.querySelectorAll('.stat-card__value')].map((node) => node.textContent.trim());
const labels = [...document.querySelectorAll('.stat-card__label')].map((node) => node.textContent.trim());
values.join('|') === '20|2x|2200'
labels.join('|') === 'Team size|Monthly revenue growth|Social media posts per month'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the stat cards render with the new content and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/about.html about.html docs/plans/2026-05-25-about-stats-content.md
git commit -m "Update about stats content"
git push origin HEAD:codex/homepage-header-hero
```
