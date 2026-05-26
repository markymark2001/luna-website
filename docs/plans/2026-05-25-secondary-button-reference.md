# Secondary Button Reference Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align the shared secondary button with Claura's actual secondary CTA treatment while using Taia's existing color tokens.

**Architecture:** Keep the correction in `.button.secondary` inside `styles/components.css` so About and future secondary CTAs inherit a single primitive. Use a filled beige treatment with no visible border, matching the reference button mechanics.

**Tech Stack:** Shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Correct Secondary Button Primitive

**Files:**
- Modify: `styles/components.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Inspect Claura reference**

Use browser evidence on `https://claura.framer.ai/about`.
Expected reference style for the secondary CTA: `44px` height, `12px` border radius, `10px 20px` padding, beige fill, no visible border, brown medium text.

- [x] **Step 2: Replace secondary button styling**

Update `.button.secondary` in `styles/components.css` to:

```css
.button.secondary {
  border-color: transparent;
  background: var(--cream-action-hover);
  color: var(--brown-action);
}

.button.secondary:hover {
  border-color: transparent;
  background: var(--cream-action-border);
}
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: the About hero secondary CTA is filled beige with no visible outline, keeps the existing 44px button height and 12px radius, and no horizontal overflow appears.

- [x] **Step 4: Commit and push**

Stage only this CSS and plan:

```bash
git add styles/components.css docs/plans/2026-05-25-secondary-button-reference.md
git commit -m "Align secondary button with reference"
git push origin HEAD:codex/homepage-header-hero
```
