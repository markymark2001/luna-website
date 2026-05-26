# Homepage Footer Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a Claura-inspired footer to the Taia homepage with valid navigation links for the planned site pages.

**Architecture:** Keep the footer as static HTML in `index.html`, styled by homepage-specific `.site-footer` classes in `style.css`. Add minimal static About, Jobs, and Contact pages so footer navigation does not introduce dead public links.

**Tech Stack:** Static HTML, CSS, local `python3 -m http.server`, Codex browser evidence.

---

### Task 1: Footer Markup And Pages

**Files:**
- Modify: `index.html`
- Create: `about.html`
- Create: `jobs.html`
- Create: `contact.html`

- [ ] Add a homepage `<footer class="site-footer">` after `</main>` with a brand block, grouped links, and a copyright row.
- [ ] Add minimal inner pages for About, Jobs, and Contact using the same document pattern as `support.html`.
- [ ] Keep links valid: homepage anchors for sections, static HTML files for pages, and `mailto:mark@mediakey.io` for direct email.

### Task 2: Footer Styling

**Files:**
- Modify: `style.css`

- [ ] Add `.site-footer` styles that adapt Claura's structure to Taia's cream and burgundy palette.
- [ ] Use a responsive grid: brand block on the left, link groups on the right, stacked on mobile.
- [ ] Preserve existing `body:not(.home-page) > footer` styling for legal/support pages.

### Task 3: Runtime Evidence

**Files:**
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] Serve the site locally with `python3 -m http.server 8080 --bind 127.0.0.1` if it is not already running.
- [ ] Open `http://127.0.0.1:8080/` in the Codex browser.
- [ ] Verify the footer appears, has no console errors, and does not overflow on desktop and mobile widths.
- [ ] Verify footer links for About, Jobs, Contact, Privacy Policy, Terms of Service, and homepage anchors resolve.
- [ ] Commit and push only the footer-related changes.
