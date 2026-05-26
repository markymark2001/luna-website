# Website Architecture Contract Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the same root architecture-document workflow used by the Luna app repo and document this website's build/deploy architecture for future agents.

**Architecture:** Add the Luna repo's exact `architecture.md` read rule to `AGENTS.md`, then create a root `architecture.md` as the durable top-level map for this static site. Keep the document focused on Eleventy source ownership, generated output, public URL contracts, GitHub Pages deployment, and verification expectations.

**Tech Stack:** Eleventy, Nunjucks, npm, GitHub Pages Actions, static HTML/CSS/JS.

---

### Task 1: Mirror the Luna Architecture Rule

**Files:**
- Modify: `AGENTS.md`
- Reference: `/Users/markvasilyev/luna/AGENTS.md`

- [x] **Step 1: Copy the rule verbatim**

Add this exact line from `/Users/markvasilyev/luna/AGENTS.md` to the operating posture section:

```markdown
Read `architecture.md` before planning or making code changes.
```

Expected: future agents are required to read the root architecture contract before planning or editing code.

### Task 2: Add the Website Architecture Contract

**Files:**
- Create: `architecture.md`
- Inspect: `eleventy.config.js`
- Inspect: `.github/workflows/pages.yml`
- Inspect: `src/`
- Inspect: `public/`

- [x] **Step 1: Document the service stack**

Create `architecture.md` with the site's static-site stack: Eleventy, Nunjucks, `public/` passthrough assets, `dist/` generated output, and GitHub Pages Actions.

- [x] **Step 2: Document source ownership**

Describe which files future agents should edit: pages under `src/pages`, layout/partials under `src/_includes`, data under `src/_data`, redirect shims through `src/_data/redirects.js` plus `src/legacy/redirects.njk`, and assets under `public`.

- [x] **Step 3: Document URL/deployment contracts**

Describe clean URLs, legacy `.html` redirect shims, support-to-contact routing, the external R2 video URL, `public/CNAME`, and the GitHub Pages workflow artifact contract.

### Task 3: Verify, Review, Commit, and Push

**Files:**
- Verify: `AGENTS.md`
- Verify: `architecture.md`
- Verify: `docs/plans/2026-05-25-architecture-contract.md`

- [x] **Step 1: Inspect Markdown**

Run:

```bash
sed -n '1,220p' AGENTS.md
sed -n '1,260p' architecture.md
sed -n '1,180p' docs/plans/2026-05-25-architecture-contract.md
```

Expected: AGENTS contains the verbatim architecture rule and the architecture contract has no placeholders.

- [x] **Step 2: Run diff checks**

Run:

```bash
git diff --check
```

Expected: no whitespace errors.

- [ ] **Step 3: Run repository review**

Run:

```bash
./.codex/scripts/codex-review.sh
```

Expected: no actionable findings for the documentation and agent-contract changes.

- [ ] **Step 4: Commit and push**

Run:

```bash
git add AGENTS.md architecture.md docs/plans/2026-05-25-architecture-contract.md
git commit -m "Document website architecture contract"
git push origin website-v2
```
