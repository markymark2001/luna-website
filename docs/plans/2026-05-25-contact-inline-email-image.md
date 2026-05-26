# Contact Inline Email Image Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Simplify the Contact page to one paragraph with an inline email link and add an image panel like the About team section.

**Architecture:** Reuse the existing `split-intro` section primitives and `media-stat-panel media-stat-panel--image-only` image primitive. Remove the contact button and second paragraph, keep email as an inline link inside one paragraph, then rebuild generated HTML and verify desktop/mobile rendering.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Simplify Contact Copy And Add Image

**Files:**
- Modify: `src/pages/contact.html`
- Modify: `styles/pages.css`
- Generate: `contact.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace right-column copy and remove button**

Use this right-column markup in `src/pages/contact.html`:

```html
<div class="split-intro__stack">
  <p class="split-intro__copy">For support, privacy, subscriptions, partnerships, or general questions, email us at <a href="mailto:mark@mediakey.io">mark@mediakey.io</a>.</p>
</div>
```

- [ ] **Step 2: Add the reused image panel**

Add this image panel below the `split-intro` block inside `.contact-section__inner`:

```html
<div class="media-stat-panel media-stat-panel--image-only" aria-label="Taia contact image">
  <img class="media-stat-panel__image" src="https://website.lunaapp.io/about-stats.webp" alt="">
</div>
```

- [ ] **Step 3: Add the page stack gap**

Add this CSS to `styles/pages.css`:

```css
.contact-section__inner {
  display: grid;
  gap: var(--space-12);
}
```

- [ ] **Step 4: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `contact.html` has no `.button.secondary` inside `.contact-page`, has one inline `mailto:mark@mediakey.io` link, and contains a `media-stat-panel--image-only` image panel.

- [ ] **Step 5: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/contact.html
```

Open `http://127.0.0.1:8081/contact.html?v=contact-inline-email-image` in the Codex browser and verify:

```js
document.querySelectorAll('.contact-page .split-intro__copy').length === 1
document.querySelector('.contact-page .split-intro__copy a').getAttribute('href') === 'mailto:mark@mediakey.io'
document.querySelector('.contact-page .button.secondary') === null
document.querySelector('.contact-page .media-stat-panel--image-only') !== null
document.querySelector('.contact-page .media-stat-panel__image').complete === true
getComputedStyle(document.querySelector('.contact-section__inner')).display === 'grid'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: Contact renders one paragraph with inline email, no button, the image panel loads, and there is no horizontal overflow.

- [ ] **Step 6: Commit and push**

Run:

```bash
git add src/pages/contact.html contact.html styles/pages.css docs/plans/2026-05-25-contact-inline-email-image.md
git commit -m "Simplify contact page with inline email"
git push origin HEAD:codex/homepage-header-hero
```
