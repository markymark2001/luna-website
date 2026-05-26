# Custom Domain Documentation Correction Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove project-path GitHub Pages guidance that conflicts with the website's root-relative custom-domain deployment.

**Architecture:** Keep the site rooted at `https://lunaapp.io/` with root-relative URLs and `public/CNAME`. Update durable documentation to make custom-domain serving a contract, not an optional follow-up.

**Tech Stack:** GitHub Pages Actions, Eleventy static artifact, Markdown docs.

---

### Task 1: Clarify Hosting Contract

**Files:**
- Modify: `architecture.md`
- Modify: `README.md`

- [x] **Step 1: Document root-domain-only serving**

Update `architecture.md` to state that the built artifact assumes a domain root and is not intended to be served from a GitHub Pages project path.

- [x] **Step 2: Remove project-path setup language**

Update `README.md` so setup points to the actual `markymark2001/luna-website` repository, GitHub Actions Pages publishing, and `https://lunaapp.io/` as the public URL.

### Task 2: Verify and Push

**Files:**
- Verify: `README.md`
- Verify: `architecture.md`

- [x] **Step 1: Inspect updated docs**

Run:

```bash
rg -n "YOUR_USERNAME|github\\.io/luna-website|project path" README.md architecture.md
sed -n '1,180p' README.md
sed -n '1,180p' architecture.md
```

Expected: no project-path hosting instructions remain.

- [x] **Step 2: Run checks and review**

Run:

```bash
npm run build
git diff --check
./.codex/scripts/codex-review.sh
```

Expected: build and diff checks pass, and review has no actionable findings.

- [ ] **Step 3: Commit and push**

Run:

```bash
git add AGENTS.md architecture.md README.md docs/plans/2026-05-25-architecture-contract.md docs/plans/2026-05-25-custom-domain-doc-correction.md
git commit -m "Document website architecture contract"
git push origin website-v2
```
