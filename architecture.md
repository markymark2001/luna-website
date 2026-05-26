# Architecture Contract

## Site Purpose

This repository is the public marketing and legal website for Taia, the
astrology app. It is a static site: there is no server-side runtime, database,
API route, or client app framework in this repo.

## Service Stack

- Eleventy builds authored source files into static HTML.
- Nunjucks renders layouts, includes, loops, page front matter, and redirect
  templates.
- `public/` contains static passthrough files copied to the artifact root.
- `dist/` is generated build output and must not be edited or committed.
- GitHub Pages serves the built artifact uploaded by GitHub Actions.
- `website.lunaapp.io` hosts external website media assets such as the homepage
  background video.

## Source Ownership

Edit source files only. Do not edit generated files under `dist/`.

- `src/pages/`: authored public pages. Each page owns its body content and
  front matter, including `layout`, `title`, `description`, `bodyClass`, and
  clean `permalink`.
- `src/design-system.html`: authored design-system reference page.
- `src/_includes/layouts/`: document shells such as the base page layout and
  redirect page layout.
- `src/_includes/partials/`: shared page chrome such as head, header, footer,
  and download CTA.
- `src/_data/`: structured data rendered by templates. Use data files for
  repeated content such as homepage feature/review content, open roles, and
  redirect routes.
- `src/legacy/redirects.njk`: the single paginated source for legacy redirect
  shim pages. Add redirect aliases through `src/_data/redirects.js`, not by
  creating one-off redirect files.
- `public/`: browser-served static files. CSS, JavaScript, images, `CNAME`, and
  other passthrough assets live here and keep their root-relative public URLs.
- `docs/`: durable specs, workflows, and implementation plans.

## Build Contract

`eleventy.config.js` sets `src` as the Eleventy input directory, `_includes` as
the includes directory, and `dist` as the output directory. It also copies
`public/` to the output root with `eleventyConfig.addPassthroughCopy({ public:
"." })`.

Use these commands:

```bash
npm run build
npm run dev
npm run clean
```

`npm run build` removes `dist` and rebuilds the full static artifact. A correct
build writes `dist/index.html`, clean page directories such as
`dist/privacy/index.html`, legacy redirect files such as `dist/privacy.html`,
and root assets such as `dist/style.css`.

## URL Contract

The generated site assumes it is served at a domain root. Production is
`https://lunaapp.io/` through the `public/CNAME` custom-domain file. Do not
serve this artifact from a GitHub Pages project subpath: root-relative
stylesheets, scripts, assets, and navigation links would resolve outside that
subpath.

Canonical authored pages use clean directory URLs:

- `/`
- `/about/`
- `/contact/`
- `/jobs/`
- `/privacy/`
- `/terms/`
- `/design-system/`

Legacy `.html` URLs remain supported through static redirect shims because
external public links may already point at them:

- `/about.html` -> `/about/`
- `/contact.html` -> `/contact/`
- `/design-system.html` -> `/design-system/`
- `/jobs.html` -> `/jobs/`
- `/privacy.html` -> `/privacy/`
- `/terms.html` -> `/terms/`

There is no standalone support page. The footer label is `Support`, but it
routes to `/contact/`. Both `/support/` and `/support.html` are redirect shims
to `/contact/`.

Do not add fallback or legacy paths unless they are needed for public URL
compatibility.

## Asset Contract

Styles are split under `public/styles/` and loaded through `public/style.css`.
Homepage behavior lives in `public/scripts/home.js`. App screenshots and logos
live under `public/assets/`.

Do not bundle large homepage video files in this repo. The homepage background
video source is the external R2/custom-domain URL:

```text
https://website.lunaapp.io/homepage-background.mp4
```

`public/CNAME` must stay in the passthrough asset set so the built artifact
contains `dist/CNAME` for the `lunaapp.io` GitHub Pages custom domain.

## Deployment Contract

GitHub Pages must stay in workflow publishing mode. The workflow at
`.github/workflows/pages.yml` installs dependencies with `npm ci`, runs
`npm run build`, uploads `dist` with `actions/upload-pages-artifact`, and
deploys with `actions/deploy-pages` only on pushes to `main`.

Pull requests should run the build job and skip deploy. After changing Pages
workflow behavior, generated URL behavior, `public/CNAME`, or artifact shape,
verify the PR Actions run and confirm the repository Pages configuration still
uses workflow publishing.

## Template Contract

Shared repeated content belongs in `src/_data/` and should be rendered through
Nunjucks loops. Prefer a single data source plus a template over copied markup
when content has the same structure.

Shared chrome belongs in `_includes/partials`. Page-specific content belongs in
the page template. Avoid adding abstractions for one-off content.

The homepage review marquee has one source `.review-group` per row in the
template. `public/scripts/home.js` clones review groups at runtime to create the
marquee length and marks clones `aria-hidden`.

## Verification Contract

For source or architecture changes, run at least:

```bash
npm run build
git diff --check
```

For browser-visible changes, serve `dist` locally and verify changed pages in
the Codex browser with no console errors. For navigation or URL changes, verify
the affected clean URLs and legacy redirect shims with HTTP checks against the
local static server.

For GitHub Pages changes, verify the PR Actions build result and that deploy is
skipped on pull requests.
