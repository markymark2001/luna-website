# Section Tag Primitive Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make every About page section tag use the same reusable primitive so the Open roles tag cannot inherit paragraph typography from `section-intro`.

**Architecture:** Replace contextual `.kicker` usage with an explicit `.section-tag` component and `.section-tag--center` alignment modifier. Scope `section-intro` body-copy styling to paragraphs that are not section tags, then rebuild generated HTML.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Centralize Section Tag Styling

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Generate: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace About tag classes**

Use this class pattern for all three About section tags:

```html
<p class="section-tag section-tag--center">Our mission</p>
<p class="section-tag">Who we are</p>
<p class="section-tag section-tag--center">Open roles</p>
```

- [ ] **Step 2: Replace `.kicker` with a reusable component**

Use this CSS in `styles/components.css`:

```css
.section-intro > p:not(.section-tag) {
  margin: var(--space-4) 0 0;
  color: var(--muted);
  font-size: var(--body);
  font-weight: 300;
  line-height: 1.5;
}

.section-tag {
  display: inline-flex;
  align-items: center;
  width: fit-content;
  margin: 0 0 var(--space-4);
  padding: 6px 12px;
  border-radius: 8px;
  background: var(--cream-action-hover);
  color: var(--brown-action);
  font-size: var(--small);
  font-weight: 500;
  line-height: 1.5;
  text-transform: none;
}

.section-tag--center {
  margin-inline: auto;
}
```

- [ ] **Step 3: Update selectors that exclude tags**

Replace `p:not(.kicker)` selectors with `p:not(.section-tag)` in `styles/pages.css` and `styles/responsive.css`.

- [ ] **Step 4: Build and inspect**

Run:

```bash
node scripts/build-site.mjs
git diff --check
rg -n "kicker|section-intro \\.section-tag|section-intro \\.kicker" src styles about.html
```

Expected: the build succeeds, no whitespace errors exist, no `.kicker` class remains in source/styles/generated About markup, and no contextual section-intro tag alignment selector remains.

- [ ] **Step 5: Runtime evidence**

Open `http://127.0.0.1:8081/about.html?v=section-tag-primitive` in the Codex browser. Verify:

```js
const tags = [...document.querySelectorAll('.section-tag')].map((tag) => {
  const style = getComputedStyle(tag);
  return {
    text: tag.textContent.trim(),
    color: style.color,
    fontSize: style.fontSize,
    fontWeight: style.fontWeight,
    backgroundColor: style.backgroundColor,
    marginTop: style.marginTop,
    marginBottom: style.marginBottom,
    centered: tag.classList.contains('section-tag--center'),
  };
});
```

Expected: all About tags share identical color, size, weight, background, and bottom margin. Only mission and open roles use `section-tag--center`.

- [ ] **Step 6: Commit and push**

Run:

```bash
git add src/pages/about.html about.html styles/components.css styles/pages.css styles/responsive.css docs/plans/2026-05-25-section-tag-primitive.md
git commit -m "Centralize section tag primitive"
git push origin HEAD:codex/homepage-header-hero
```
