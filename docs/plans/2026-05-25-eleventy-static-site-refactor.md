# Eleventy Static Site Refactor Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the custom root-file generator with a conventional static-site architecture that keeps source files authored once and writes generated output only to `dist/`.

**Architecture:** Use Eleventy as the static-site generator, because it directly supports HTML templates, layouts, includes, passthrough assets, local serving, and small static sites without adding a client framework. Keep page bodies in `src/pages`, shared layout pieces in `src/_includes`, public assets in `public`, and ignored build output in `dist`. Deploy through GitHub Pages Actions so the repository no longer needs committed generated root HTML.

**Tech Stack:** Eleventy, Node.js/npm, Nunjucks layouts/includes, GitHub Pages Actions, Python local static server for launcher compatibility.

---

### Task 1: Install the Static Site Tooling

**Files:**
- Create: `package.json`
- Create: `package-lock.json`
- Create: `.gitignore`

- [ ] **Step 1: Add npm project metadata**

Create `package.json` with build, serve, and clean scripts:

```json
{
  "name": "luna-website",
  "private": true,
  "type": "module",
  "scripts": {
    "build": "eleventy",
    "dev": "eleventy --serve",
    "clean": "rm -rf dist"
  },
  "devDependencies": {
    "@11ty/eleventy": "^3.1.5"
  }
}
```

- [ ] **Step 2: Install dependencies**

Run:

```bash
npm install
```

Expected: `package-lock.json` is created and Eleventy installs locally.

- [ ] **Step 3: Ignore local build artifacts**

Create `.gitignore` with:

```gitignore
node_modules/
dist/
```

### Task 2: Replace Custom Generation with Eleventy

**Files:**
- Create: `eleventy.config.js`
- Delete: `scripts/build-site.mjs`
- Move: `src/partials/*` to `src/_includes/partials/*`
- Create: `src/_includes/layouts/base.njk`
- Modify: `src/pages/*.html`
- Move: `style.css`, `styles/`, `scripts/home.js`, `assets/`, `CNAME` to `public/`
- Move: `design-system.html` to `src/design-system.html`

- [ ] **Step 1: Add Eleventy config**

Create `eleventy.config.js`:

```js
export default function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy({ public: "." });

  return {
    dir: {
      input: "src",
      includes: "_includes",
      output: "dist"
    },
    htmlTemplateEngine: "njk",
    markdownTemplateEngine: "njk"
  };
}
```

- [ ] **Step 2: Add the shared layout**

Create `src/_includes/layouts/base.njk`:

```njk
<!doctype html>
<html lang="en">
  {% include "partials/head.njk" %}
  <body id="top" class="{{ bodyClass }}">
    {% include "partials/header.njk" %}

    {{ content | safe }}

    {% include "partials/footer.njk" %}
    {% for script in pageScripts or [] %}
    <script src="{{ script }}"></script>
    {% endfor %}
  </body>
</html>
```

- [ ] **Step 3: Convert page fragments to Eleventy pages**

Prepend each `src/pages/*.html` page with front matter that sets `layout`, `title`, `description`, `bodyClass`, and `permalink`. Add `pageScripts: ["scripts/home.js"]` only to the homepage.

Expected: Eleventy writes the same public paths as before: `index.html`, `privacy.html`, `terms.html`, `about.html`, `contact.html`, `jobs.html`, and `support.html`.

- [ ] **Step 4: Move public files under `public`**

Move static assets and pass-through files so source-owned public files are grouped together:

```bash
mkdir -p public
mv assets public/assets
mv scripts public/scripts
mv styles public/styles
mv style.css public/style.css
mv CNAME public/CNAME
```

Expected: existing URLs still work from the generated site because `public` is copied to the output root.

- [ ] **Step 5: Move the design-system page into source**

Move `design-system.html` to `src/design-system.html` and prepend:

```yaml
---
permalink: design-system.html
layout: false
---
```

Expected: `dist/design-system.html` is generated, while the repo root no longer contains the public HTML file.

### Task 3: Update Local and GitHub Pages Workflows

**Files:**
- Create: `.github/workflows/pages.yml`
- Modify: `.codex/scripts/launch-website.sh`
- Modify: `docs/workflows/runtime-evidence.md`
- Modify: `README.md`

- [ ] **Step 1: Add Pages deployment workflow**

Create `.github/workflows/pages.yml` using `actions/configure-pages`, `actions/upload-pages-artifact`, and `actions/deploy-pages` to build `dist` from `npm ci && npm run build`.

Expected: pushes to `main` deploy the generated `dist` artifact once repository Pages settings are switched to GitHub Actions.

- [ ] **Step 2: Serve generated output locally**

Update `.codex/scripts/launch-website.sh` so it runs `npm run build`, verifies `dist/index.html`, and serves `dist` instead of the repository root.

Expected: the launch script opens a browser on the generated site rather than stale root files.

- [ ] **Step 3: Update durable docs**

Update `README.md` and `docs/workflows/runtime-evidence.md` to describe the new source directories, `npm run build`, `npm run dev`, and serving `dist`.

Expected: future edits happen in `src/` or `public/`; generated output is never edited directly.

### Task 4: Verify, Review, Commit, and Push

**Files:**
- Verify: all changed source, generated output, local launch script, and Pages workflow.

- [ ] **Step 1: Build the site**

Run:

```bash
npm run build
```

Expected: Eleventy writes all public pages and assets to `dist`.

- [ ] **Step 2: Smoke-check generated pages**

Run a local static server from `dist`:

```bash
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

Then run:

```bash
curl -I http://127.0.0.1:8080/
curl -I http://127.0.0.1:8080/privacy.html
curl -I http://127.0.0.1:8080/terms.html
curl -I http://127.0.0.1:8080/support.html
```

Expected: each page returns `200 OK`.

- [ ] **Step 3: Capture browser evidence**

Open the generated homepage and representative legal/support pages in the Codex browser. Check desktop and mobile widths for the homepage because deployment architecture changed but CSS should remain visually stable. Confirm there are no browser console errors.

- [ ] **Step 4: Inspect changed files**

Run:

```bash
git status --short
git diff --stat
git diff --check
```

Expected: no whitespace errors and only the planned architecture files changed.

- [ ] **Step 5: Commit and push**

Run:

```bash
git add .
git commit -m "Refactor website static build architecture"
git push origin website-v2
```

Expected: `website-v2` is pushed with the Eleventy architecture refactor.
