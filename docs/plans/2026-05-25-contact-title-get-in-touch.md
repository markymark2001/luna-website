# Contact Title Get In Touch Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change the Contact page title from `Contact Taia` to `Get in touch`.

**Architecture:** Keep the current split contact section and primitives unchanged. Replace only the heading text in the Contact source fragment, rebuild generated HTML, verify rendering, then commit and push.

**Tech Stack:** Static HTML fragments, shared CSS components, `node scripts/build-site.mjs`, local HTTP server, Codex browser runtime evidence.

---

### Task 1: Update Contact Heading

**Files:**
- Modify: `src/pages/contact.html`
- Generate: `contact.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Replace heading text**

Change this heading in `src/pages/contact.html`:

```html
<h1 id="contact-title" class="section-title">Contact Taia</h1>
```

to:

```html
<h1 id="contact-title" class="section-title">Get in touch</h1>
```

- [ ] **Step 2: Build generated HTML**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `contact.html` contains `Get in touch` and no longer contains `Contact Taia`.

- [ ] **Step 3: Verify locally**

Run:

```bash
git diff --check
curl -I http://127.0.0.1:8081/contact.html
```

Open `http://127.0.0.1:8081/contact.html?v=contact-title-get-in-touch` in the Codex browser and verify:

```js
document.querySelector('#contact-title').textContent.trim() === 'Get in touch'
document.documentElement.scrollWidth <= window.innerWidth
```

Expected: the Contact page title renders as `Get in touch` and there is no horizontal overflow.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add src/pages/contact.html contact.html docs/plans/2026-05-25-contact-title-get-in-touch.md
git commit -m "Update contact page title"
git push origin HEAD:codex/homepage-header-hero
```
