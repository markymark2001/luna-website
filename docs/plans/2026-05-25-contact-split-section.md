# Contact Split Section Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the Contact page to reuse the same side-by-side split section primitives as the About team section.

**Architecture:** Replace the legacy `.content` contact markup with a full-width content page section using `section-band`, `wrap`, `split-intro`, `section-tag`, and `section-title`. Add a reusable `split-intro__stack` primitive for right-column copy plus an email button, then rebuild generated HTML and verify rendering.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Convert Contact Page To Split Section

**Files:**
- Modify: `src/pages/contact.html`
- Modify: `styles/components.css`
- Modify: `styles/pages.css`
- Generate: `contact.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace legacy Contact markup**

Use this markup in `src/pages/contact.html`:

```html
<main class="contact-page">
  <section class="section-band contact-section" aria-labelledby="contact-title">
    <div class="wrap contact-section__inner">
      <div class="split-intro">
        <div>
          <p class="section-tag">Contact</p>
          <h1 id="contact-title" class="section-title">Contact Taia</h1>
        </div>
        <div class="split-intro__stack">
          <p class="split-intro__copy">For support, privacy, subscriptions, partnerships, or general questions, reach us by email.</p>
          <p class="split-intro__copy">We typically respond within 24-48 hours during business days.</p>
          <a class="button secondary" href="mailto:mark@mediakey.io">
            <span>Email us</span>
            <span aria-hidden="true">Email us</span>
          </a>
        </div>
      </div>
    </div>
  </section>
</main>
```

- [ ] **Step 2: Add a reusable split stack primitive**

Add this CSS to `styles/components.css`:

```css
.split-intro__stack {
  display: grid;
  justify-items: start;
  gap: var(--space-4);
}
```

- [ ] **Step 3: Let Contact use full-width section layout**

Add this CSS to `styles/pages.css` near the existing About full-width override:

```css
.content-page > main.contact-page {
  width: 100%;
  padding: 0;
}
```

- [ ] **Step 4: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `contact.html` contains the new split section and no legacy `.content`, `.contact-info`, or back link markup.

- [ ] **Step 5: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/contact.html
```

Open `http://127.0.0.1:8081/contact.html?v=contact-split-section` in the Codex browser and verify:

```js
document.querySelector('.contact-page .split-intro') !== null
document.querySelector('.contact-page .split-intro__stack') !== null
document.querySelector('.contact-page .section-tag').textContent.trim() === 'Contact'
document.querySelector('#contact-title').textContent.trim() === 'Contact Taia'
document.querySelector('.contact-page .button.secondary').getAttribute('href') === 'mailto:mark@mediakey.io'
document.querySelector('.contact-page .content') === null
document.querySelector('.contact-page .contact-info') === null
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: Contact renders as a split section using shared primitives, the email button works, legacy contact markup is gone, and there is no horizontal overflow.

- [ ] **Step 6: Commit and push**

Run:

```bash
git add src/pages/contact.html contact.html styles/components.css styles/pages.css docs/plans/2026-05-25-contact-split-section.md
git commit -m "Refactor contact page split section"
git push origin HEAD:codex/homepage-header-hero
```
