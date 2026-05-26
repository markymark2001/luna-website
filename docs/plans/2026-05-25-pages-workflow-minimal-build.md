# Pages Workflow Minimal Build Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the unnecessary Pages setup step from the build job so the GitHub Pages workflow cannot fail before uploading the Eleventy artifact due to missing Pages write permission.

**Architecture:** Keep build jobs read-only on pull requests. Build `dist`, upload it with `actions/upload-pages-artifact`, and reserve `pages: write` plus `id-token: write` for the `main`-only deploy job.

**Tech Stack:** GitHub Pages Actions, Eleventy, npm.

---

### Task 1: Simplify Pages Build Job

**Files:**
- Modify: `.github/workflows/pages.yml`

- [x] **Step 1: Remove Pages setup from build**

Delete the `actions/configure-pages` step from the build job. The workflow should still install dependencies, run `npm run build`, and upload `dist`.

Expected: pull request build jobs remain read-only and do not invoke Pages setup APIs.

### Task 2: Verify and Push

**Files:**
- Verify: `.github/workflows/pages.yml`

- [x] **Step 1: Run local checks**

Run:

```bash
npm run build
git diff --check
```

Expected: build succeeds and diff check passes.

- [x] **Step 2: Run repository review**

Run:

```bash
./.codex/scripts/codex-review.sh
```

Expected: review has no actionable workflow findings.

- [ ] **Step 3: Commit and push**

Run:

```bash
git add .github/workflows/pages.yml AGENTS.md architecture.md README.md docs/plans/2026-05-25-architecture-contract.md docs/plans/2026-05-25-custom-domain-doc-correction.md docs/plans/2026-05-25-pages-workflow-minimal-build.md
git commit -m "Document website architecture contract"
git push origin website-v2
```
