# About Page Design

## Goal

Build one polished company page for Taia that combines the current About and Jobs surfaces without removing the public Jobs footer entry.

## Approved Structure

The About page contains these sections, in order:

1. Mission
2. Who we are
3. What we build
4. Values
5. Jobs
6. Existing shared footer

The separate public Jobs link remains in the footer, but it points directly to the Jobs section on the About page.

## Content Direction

The page should be concise and avoid a bloated company narrative. It should describe Taia as a personal astrology app that helps people ask better questions, reflect with clarity, and use astrology as practical guidance for real life.

The Jobs section should state when there are no open roles and provide a direct email application path for future opportunities.

## Design Direction

Reuse the homepage design system: existing typography scale, spacing tokens, cream palette, button component, shared header, shared footer, and root build flow. Borrow from the Claura reference only where it fits the existing system: spacious editorial composition, large mission headline, soft rounded surfaces, and a compact careers callout.

Do not add a separate Team/Company section. Fold the company/team description into Who we are, with a Claura-style image strip to give the page the same people-forward visual language.

Values should use a large visual band with soft translucent panels, not plain isolated cards.

Shared page proportions should live in system-level tokens and reusable components, not page-specific one-off CSS. Section bands, headings, split layouts, media cards, visual bands, and translucent panels should be reusable across future static pages.

## Navigation Contract

- Footer About link: `about.html`
- Footer Jobs link: `about.html#jobs`
- `jobs.html` remains available for URL compatibility and directs users to `about.html#jobs`.

## Verification

Serve the generated static site locally and verify:

- `about.html` renders at desktop and mobile widths.
- Footer Jobs navigates to the About page Jobs section.
- `jobs.html` preserves URL compatibility and reaches the Jobs section.
- Browser console has no errors on affected pages.
