# GitHub Pages Workflow Readiness Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ensure the Eleventy architecture deploys through GitHub Pages Actions after `website-v2` merges.

**Architecture:** Keep `dist` as the generated artifact uploaded by the Pages workflow, with `index.html` and `CNAME` at the artifact root. Configure the repository Pages source to workflow mode before merge so `actions/deploy-pages` can deploy from the merged workflow instead of the removed root HTML files.

**Tech Stack:** GitHub Pages Actions, GitHub REST Pages API, Eleventy.

---

### Task 1: Verify Live Pages Mode

**Files:**
- Verify: repository Pages settings
- Modify: `.github/workflows/pages.yml`

- [ ] **Step 1: Read current Pages settings**

Run:

```bash
gh api repos/markymark2001/luna-website/pages --jq '{build_type, cname, source, https_enforced}'
```

Expected before the fix: `build_type` may be `legacy`, which would not deploy an artifact after root HTML files are removed.

- [ ] **Step 2: Switch Pages to workflow mode**

Run:

```bash
gh api -X PUT repos/markymark2001/luna-website/pages -f build_type=workflow
```

Expected after the fix: `build_type` is `workflow` and `cname` remains `lunaapp.io`.

- [ ] **Step 3: Align workflow with current Pages Actions docs**

In `.github/workflows/pages.yml`, use `actions/upload-pages-artifact@v4` and keep deploy permissions scoped to the deploy job:

```yaml
permissions:
  contents: read

jobs:
  build:
    steps:
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: dist

  deploy:
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: read
      pages: write
      id-token: write
```

### Task 2: Verify and Push

**Files:**
- Verify: `.github/workflows/pages.yml`
- Verify: generated `dist`

- [ ] **Step 1: Build locally**

Run:

```bash
npm run build
```

Expected: Eleventy writes `dist/index.html`, `dist/CNAME`, and all public pages.

- [ ] **Step 2: Confirm PR Actions status**

Run:

```bash
gh pr checks 6 --watch=false
```

Expected: the build job passes and the deploy job is skipped on pull requests.

- [ ] **Step 3: Commit and push**

Run:

```bash
git add .github/workflows/pages.yml docs/plans/2026-05-25-gh-pages-workflow-readiness.md
git commit -m "Harden GitHub Pages workflow setup"
git push origin website-v2
```
