# Homepage Journey Copy Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the homepage feature-block copy on `website-v2` with user-journey copy grounded in recent Taia conversation research.

**Architecture:** Keep the existing static homepage structure and four `feature-block` articles. Update only the `h2` and `p` text in `src/pages/index.html`, then run the site builder so root `index.html` stays in sync for GitHub Pages.

**Tech Stack:** Static HTML, existing Node build script, Python local static server, Codex browser verification.

---

### Task 1: Update Homepage Copy

**Files:**
- Modify: `src/pages/index.html`
- Modify through build: `index.html`

- [ ] **Step 1: Replace the four feature-block text pairs**

Update the existing feature blocks to:

```html
<h2>Say what’s real</h2>
<p>A text you want to send. A person you cannot read. A decision that keeps looping. A low mood, a strange dream, or a question about where your life is heading.</p>

<h2>Read the pattern</h2>
<p>Taia looks at your placements, timing, compatibility, and current energy to give you guidance that feels personal instead of generic.</p>

<h2>Go deeper</h2>
<p>Ask follow-ups, check another angle, or stay with the same question until the answer starts to land.</p>

<h2>Move with trust</h2>
<p>Leave with clearer words, better timing, stronger boundaries, or an intention that helps you meet the moment instead of spiraling around it.</p>
```

- [ ] **Step 2: Build the generated site files**

Run:

```bash
node scripts/build-site.mjs
```

Expected: `index.html` is rebuilt and contains the same four updated text pairs.

- [ ] **Step 3: Inspect the diff**

Run:

```bash
git diff -- src/pages/index.html index.html docs/plans/2026-05-25-homepage-journey-copy.md
```

Expected: only the plan file plus the homepage copy changes are present.

### Task 2: Verify Static Homepage Rendering

**Files:**
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Serve the site locally**

Run from repo root:

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

If port `8080` is busy, use another local port and record the exact URL.

- [ ] **Step 2: Check the affected page in the browser**

Open:

```text
http://127.0.0.1:8080/
```

Expected: the four feature blocks show `Say what’s real`, `Read the pattern`, `Go deeper`, and `Move with trust`; no browser console errors are present.

- [ ] **Step 3: Check local HTTP response**

Run:

```bash
curl -I http://127.0.0.1:8080/
```

Expected: `HTTP/1.0 200 OK` or equivalent `200` response.

### Task 3: Commit And Push Website V2

**Files:**
- Stage: `src/pages/index.html`
- Stage: `index.html`
- Stage: `docs/plans/2026-05-25-homepage-journey-copy.md`

- [ ] **Step 1: Confirm branch and unrelated changes**

Run:

```bash
git status --short --branch
```

Expected: branch is `website-v2`; any pre-existing `AGENTS.md` change remains unstaged.

- [ ] **Step 2: Commit scoped files**

Run:

```bash
git add src/pages/index.html index.html docs/plans/2026-05-25-homepage-journey-copy.md
git commit -m "Update homepage journey copy"
```

Expected: commit succeeds without staging `AGENTS.md`.

- [ ] **Step 3: Push website-v2**

Run:

```bash
git push origin website-v2
```

Expected: remote `website-v2` is updated with the new homepage copy.
