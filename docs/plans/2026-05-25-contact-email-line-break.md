# Contact Email Line Break Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Put the contact email on its own spaced line and make it darker than the paragraph copy.

**Architecture:** Keep the Contact page as one paragraph with an inline mail link in the semantic content. Add a reusable split-copy link primitive so links inside split intro copy use the darker action color, and a `split-intro__link-line` modifier to display the email on its own line with one line of spacing.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Contact Email Line

**Files:**
- Modify: `src/pages/contact.html`
- Modify: `styles/components.css`
- Generate: `contact.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Put the email link on its own line**

Change the contact paragraph in `src/pages/contact.html` to:

```html
<p class="split-intro__copy">For support, privacy, subscriptions, partnerships, or general questions, email us at <a class="split-intro__link-line" href="mailto:mark@mediakey.io">mark@mediakey.io</a></p>
```

- [ ] **Step 2: Add shared split-copy link styles**

Add this CSS to `styles/components.css`:

```css
.split-intro__copy a {
  color: var(--brown-action);
  font-weight: 500;
  text-decoration-color: currentColor;
  text-underline-offset: 4px;
}

.split-intro__link-line {
  display: block;
  margin-top: 1lh;
  width: fit-content;
}
```

- [ ] **Step 3: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `contact.html` has the email link with `class="split-intro__link-line"`.

- [ ] **Step 4: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/contact.html
```

Open `http://127.0.0.1:8081/contact.html?v=contact-email-line-break` in the Codex browser and verify:

```js
const link = document.querySelector('.contact-page .split-intro__link-line');
const style = getComputedStyle(link);
link.getAttribute('href') === 'mailto:mark@mediakey.io'
style.display === 'block'
style.color === 'rgb(43, 24, 10)'
parseFloat(style.marginTop) > 0
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the email is on its own spaced line, uses the darker action color, and there is no horizontal overflow.

- [ ] **Step 5: Commit and push**

Run:

```bash
git add src/pages/contact.html contact.html styles/components.css docs/plans/2026-05-25-contact-email-line-break.md
git commit -m "Style contact email link line"
git push origin HEAD:codex/homepage-header-hero
```
