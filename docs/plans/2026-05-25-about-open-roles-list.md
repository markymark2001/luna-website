# About Open Roles List Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Jobs card CTA with a centered open-roles section and a list of three open positions.

**Architecture:** Keep the existing `#jobs` anchor and `section-band` primitive. Replace the card wrapper with centered heading copy and semantic role links styled as simple rows, similar to careers/open-roles lists.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Convert Jobs Card To Role List

**Files:**
- Modify: `src/pages/about.html`
- Modify: `styles/pages.css`
- Modify: `styles/responsive.css`
- Modify: `about.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Confirm current Jobs card**

Open `src/pages/about.html`.
Expected: `#jobs` contains `.about-jobs__inner`, a Jobs kicker, "Want to build Taia with us?", text saying no open roles, and one "Apply by email" button.

- [x] **Step 2: Replace Jobs markup**

Replace the Jobs section content with:

```html
<section id="jobs" class="section-band about-jobs" aria-labelledby="jobs-title">
  <div class="wrap about-jobs__inner">
    <div class="about-jobs__heading">
      <p class="kicker">Open roles</p>
      <h2 id="jobs-title" class="section-title">Come build Taia with us.</h2>
      <p>We are hiring for a small number of high-impact roles. Send a short note with the role you are interested in and what you would like to build.</p>
    </div>
    <div class="about-jobs__list" aria-label="Open positions">
      <a class="about-job" href="mailto:mark@mediakey.io?subject=Founding%20Product%20Designer">
        <span>
          <strong>Founding Product Designer</strong>
          <small>Product and brand systems</small>
        </span>
        <em>Remote</em>
      </a>
      <a class="about-job" href="mailto:mark@mediakey.io?subject=Founding%20iOS%20Engineer">
        <span>
          <strong>Founding iOS Engineer</strong>
          <small>Swift, app experience, subscriptions</small>
        </span>
        <em>Remote</em>
      </a>
      <a class="about-job" href="mailto:mark@mediakey.io?subject=Astrology%20Content%20Lead">
        <span>
          <strong>Astrology Content Lead</strong>
          <small>Guidance, rituals, interpretation quality</small>
        </span>
        <em>Remote</em>
      </a>
    </div>
  </div>
</section>
```

- [x] **Step 3: Replace Jobs CSS**

In `styles/pages.css`, remove card/flex rules for `.about-jobs__inner` and add list styling:

```css
.about-jobs__inner {
  display: grid;
  gap: var(--space-12);
}

.about-jobs__heading {
  max-width: 720px;
  margin: 0 auto;
  text-align: center;
}

.about-jobs__heading .kicker {
  margin-inline: auto;
}

.about-jobs__list {
  display: grid;
  max-width: 820px;
  margin: 0 auto;
  border-top: 1px solid var(--burgundy-line);
}
```

- [x] **Step 4: Add role row CSS**

In `styles/pages.css`, add:

```css
.about-job {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-6);
  padding: var(--space-6) 0;
  border-bottom: 1px solid var(--burgundy-line);
  color: var(--ink);
  text-decoration: none;
}
```

- [x] **Step 5: Add mobile CSS**

In `styles/responsive.css`, replace `.about-jobs__inner` flex overrides with:

```css
.about-jobs__inner {
  gap: var(--space-10);
}

.about-job {
  align-items: flex-start;
  flex-direction: column;
  gap: var(--space-3);
}
```

- [x] **Step 6: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html#jobs` in the Codex browser at desktop and mobile widths.
Expected: Jobs has centered title/subtitle, exactly three role rows, no old card or "no open roles" copy, and no horizontal overflow.

- [x] **Step 7: Commit and push**

Stage only the About source/generated HTML, CSS, and this plan:

```bash
git add src/pages/about.html about.html styles/pages.css styles/responsive.css docs/plans/2026-05-25-about-open-roles-list.md
git commit -m "Show open roles list on about page"
git push origin HEAD:codex/homepage-header-hero
```
