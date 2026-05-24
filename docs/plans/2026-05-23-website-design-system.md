# Website Design System Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a standalone HTML design-system page that establishes Luna website typography, color, spacing, and button primitives for the upcoming public-site remake.

**Architecture:** Add one static `design-system.html` page at the repository root with self-contained CSS tokens and specimen sections. The page uses Halant for serif display typography, Poppins for body/UI text, Luna app colors from `/Users/markvasilyev/luna/lib/core/theme/colors.dart`, and Claura-inspired layout primitives observed from `https://claura.framer.ai/`.

**Tech Stack:** Static HTML, CSS custom properties, Google Fonts CSS for Halant and Poppins, local Python HTTP server, Codex browser runtime evidence.

---

### Task 1: Research Inputs

**Files:**
- Read: `docs/README.md`
- Read: `docs/workflows/writing-plans.md`
- Read: `docs/workflows/runtime-evidence.md`
- Read: `/Users/markvasilyev/luna/lib/core/theme/colors.dart`
- Read: `/Users/markvasilyev/luna/lib/core/theme/design_constants.dart`
- Inspect: `https://claura.framer.ai/`

- [x] **Step 1: Inspect repo workflow docs**

Run:

```bash
sed -n '1,220p' docs/README.md
sed -n '1,260p' docs/workflows/writing-plans.md
sed -n '1,260p' docs/workflows/runtime-evidence.md
```

Expected: confirm plan and browser evidence requirements for static visual work.

- [x] **Step 2: Inspect Luna app design tokens**

Run:

```bash
sed -n '1,220p' /Users/markvasilyev/luna/lib/core/theme/colors.dart
sed -n '1,220p' /Users/markvasilyev/luna/lib/core/theme/design_constants.dart
```

Expected: capture Luna color and spacing primitives: `#DDC9C2`, `#1A0210`, `#150213`, `#786B66`, 4px spacing scale, and established radii.

- [x] **Step 3: Inspect Claura reference site**

Open `https://claura.framer.ai/` in the Codex browser and capture computed styles for headings, buttons, colors, and visible structure.

Expected: identify Halant display typography, Poppins replacement target for body text, cream field, dark CTA pills, soft secondary buttons, centered hero layout, and broad section spacing.

### Task 2: Design System Page

**Files:**
- Create: `design-system.html`

- [ ] **Step 1: Create design-system shell**

Create `design-system.html` with semantic sections:

```html
<main>
  <section class="hero">...</section>
  <section id="colors">...</section>
  <section id="typography">...</section>
  <section id="spacing">...</section>
  <section id="buttons">...</section>
  <section id="surfaces">...</section>
</main>
```

Expected: one standalone page that can be opened directly or served locally.

- [ ] **Step 2: Define CSS primitives**

Add CSS custom properties for:

```css
:root {
  --font-serif: "Halant", Georgia, serif;
  --font-sans: "Poppins", system-ui, sans-serif;
  --color-cream: #ddc9c2;
  --color-ink: #1a0210;
  --color-deep: #150213;
  --color-surface: #fcf9f9;
  --color-taupe: #786b66;
}
```

Expected: typography, color, spacing, radius, and shadow primitives are visible and named for future reuse.

- [ ] **Step 3: Add specimen content**

Add font size samples, color chips, spacing bars, primary/secondary/ghost buttons, content cards, and a sample landing-page composition.

Expected: future redesign decisions can reference this page without inspecting app code or the external reference.

### Task 3: Verification

**Files:**
- Verify: `design-system.html`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Inspect static file**

Run:

```bash
sed -n '1,260p' design-system.html
```

Expected: valid HTML structure, no obvious placeholder text, no missing CSS variables.

- [ ] **Step 2: Serve locally**

Run:

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

Expected: server starts from repo root. If port 8080 is busy, use another local port and record it.

- [ ] **Step 3: Browser verify desktop and mobile**

Open:

```text
http://127.0.0.1:8080/design-system.html
```

Check desktop and mobile viewports, inspect console errors, and capture a screenshot for presentation.

Expected: design-system page renders, typography loads, content fits without overlap, and console has no errors.

### Task 4: Present

**Files:**
- Report: `design-system.html`

- [ ] **Step 1: Report result without PR**

Summarize the created page, local verification, reference-site findings, and any follow-up design decisions. Do not create a PR.

Expected: user can review the local design-system page before the broader website remake starts.
