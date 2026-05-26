# Kicker Claura Alignment Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct the shared kicker tag so it matches Claura's actual label treatment more closely while still using Taia's color tokens.

**Architecture:** Keep the fix centralized in `.kicker` inside `styles/components.css`. Remove the outline and over-rounded pill treatment, restore readable 14px text, and use a subtle beige fill with Taia's brown action color.

**Tech Stack:** Static HTML partials, shared CSS primitives, Node static build script, local HTTP server, Codex browser evidence.

---

### Task 1: Correct Shared Kicker Styling

**Files:**
- Modify: `styles/components.css`
- Verify: `docs/workflows/runtime-evidence.md`

- [x] **Step 1: Inspect Claura reference**

Use browser evidence on `https://claura.framer.ai/about`.
Expected reference style: no border, `8px` border radius, beige background, 14px medium text, sentence case text.

- [x] **Step 2: Replace current kicker styling**

Update `.kicker` in `styles/components.css` to:

```css
.kicker {
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
```

- [x] **Step 3: Build and verify**

Run:

```bash
node scripts/build-site.mjs
git diff --check
curl -I http://127.0.0.1:8081/about.html
```

Open `http://127.0.0.1:8081/about.html` in the Codex browser at desktop and mobile widths.
Expected: About labels have no border, squared-soft `8px` corners, muted beige fill, brown text, sentence case, centered mission label, and no horizontal overflow.

- [x] **Step 4: Commit and push**

Stage only this CSS and plan:

```bash
git add styles/components.css docs/plans/2026-05-25-kicker-claura-alignment.md
git commit -m "Align section kicker tags with reference"
git push origin HEAD:codex/homepage-header-hero
```
