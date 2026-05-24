# Reference Style Guide Design System Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Supersede the first design-system draft with a single-page HTML style guide that is both operationally useful and visually aligned with the Claura reference.

**Architecture:** Keep `design-system.html` as a standalone static artifact with embedded CSS and semantic HTML sections. The page should behave like a compact brand/style-guide document: a reference-inspired hero, followed by practical foundations sections for color, typography, spacing, radius, motion, and surfaces, with actual rendered examples and token values.

**Tech Stack:** Static HTML, CSS custom properties, Google Fonts for Halant and Poppins, local Chrome/browser screenshot verification, repo Codex review.

---

### Task 1: Reframe The Artifact

**Files:**
- Modify: `design-system.html`
- Read: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Recheck reference styling**

Open `https://claura.framer.ai/` and record concrete primitives:

```text
Display font: Halant
Sans/body reference: Geist, replaced by Poppins for Luna
Reference body field: #FCF6EF
Reference section field: #F6F0E9
Reference soft control: #EFE7DD
Reference action: #2B180A
Button radius: 12px
Large media/surface radius: 24px
```

Expected: the implementation is grounded in extracted values and relationships, not generic style-guide defaults.

- [x] **Step 2: Reframe the page structure**

Replace the token-table/card look with a brand-forward style-guide layout:

```html
<header class="top-field">
  <nav class="nav">...</nav>
  <div class="hero">...</div>
</header>
<main class="body-field">
  <section id="colors">...</section>
  <section id="type">...</section>
  <section id="space">...</section>
  <section id="radius">...</section>
  <section id="motion">...</section>
  <section>...</section>
</main>
```

Expected: the artifact is still a design system, but visually uses the same grammar as the reference: open spacing, centered intro, cream fields, compact buttons, and large surfaces.

### Task 2: Foundations Content

**Files:**
- Modify: `design-system.html`

- [x] **Step 1: Define color roles**

Use semantic role tokens:

```css
--cream-header: #f6decc;
--cream-body: #fce4d2;
--cream-section: #efd5c0;
--cream-action: #efd5c0;
--cream-action-hover: #e8c8ad;
--cream-reference-body: #fcf6ef;
--cream-reference-section: #f6f0e9;
--ink: #1a0210;
--brown-action: #2b180a;
--muted: #94877c;
```

Expected: the page documents the full usable palette roles, including reference-derived colors and Luna-specific colors.

- [x] **Step 2: Define typography roles**

Use:

```css
--font-serif: "Halant", Georgia, "Times New Roman", serif;
--font-sans: "Poppins", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

Expected: Halant handles brand/display hierarchy; Poppins handles body, labels, controls, and operational text.

- [x] **Step 3: Define spacing, radius, and motion**

Document the visible primitive sets:

```css
--radius-button: 12px;
--radius-media: 24px;
--duration-fast: 150ms;
--duration-base: 240ms;
--ease-out: cubic-bezier(0.22, 1, 0.36, 1);
--ease-press: cubic-bezier(0.2, 0, 0, 1);
```

Expected: buttons, radius, and motion are first-class sections instead of hidden implementation details.

### Task 3: Verification

**Files:**
- Verify: `design-system.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Render desktop screenshot**

Run:

```bash
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless=new --disable-gpu --hide-scrollbars --window-size=1280,900 --screenshot=/tmp/luna-design-system-secondary-fixed.png file:///Users/markvasilyev/.codex/worktrees/ad5c/luna-website/design-system.html
```

Expected: the page opens, hero typography fits, secondary button is visible against the header field, and the preview strip renders.

- [x] **Step 2: Render mobile screenshot**

Run:

```bash
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless=new --disable-gpu --hide-scrollbars --window-size=390,900 --screenshot=/tmp/luna-design-system-rewrite-mobile-2.png file:///Users/markvasilyev/.codex/worktrees/ad5c/luna-website/design-system.html
```

Expected: the hero headline does not clip and controls remain usable at mobile width.

- [ ] **Step 3: Run repo review**

After committing the implementation:

```bash
./.codex/scripts/codex-review.sh
```

Expected: review returns no valid blocking findings, or valid findings are fixed before push.

### Task 4: Publish

**Files:**
- Commit: `design-system.html`
- Commit: `docs/plans/2026-05-23-website-design-system.md`
- Commit: `docs/plans/2026-05-24-reference-style-guide-design-system.md`

- [ ] **Step 1: Stage and commit**

Run:

```bash
git add design-system.html docs/plans/2026-05-23-website-design-system.md docs/plans/2026-05-24-reference-style-guide-design-system.md
git commit -m "Add Luna website design system"
```

Expected: one commit contains the standalone design-system page and historical/superseding plans.

- [ ] **Step 2: Verify merge cleanliness**

Run:

```bash
git fetch https://github.com/markymark2001/luna-website.git main:refs/remotes/origin/main
git merge-tree "$(git merge-base HEAD origin/main)" HEAD origin/main
```

Expected: no conflict markers or conflicting file entries.

- [ ] **Step 3: Push and open PR**

Run:

```bash
git push -u https://github.com/markymark2001/luna-website.git codex/design-system-foundations
gh pr create --base main --head codex/design-system-foundations --title "[codex] Add Luna website design system" --body-file /tmp/luna-website-design-system-pr.md
```

Expected: non-draft PR opens against `main`.
