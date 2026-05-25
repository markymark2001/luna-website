# Runtime Evidence

Pick the smallest public browser path that proves the changed website behavior.
Launching a local server alone counts only when server startup or static hosting
is the behavior being verified.

## When Required

Runtime evidence is required when changed behavior depends on the browser:

- layout, CSS, responsive behavior, or visual presentation;
- navigation, anchors, cross-page links, or public URL paths;
- support, privacy, terms, or landing-page rendering;
- accessibility-affecting markup;
- user-reported website behavior;
- GitHub Pages or custom-domain behavior.

Skip browser evidence for documentation-only changes unless the documentation
describes browser-visible behavior.

## Local Server

Build the generated site:

```bash
npm run build
```

Serve the generated site from `dist`:

```bash
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

If port `8080` is busy, choose another local port and state the exact URL used.
Do not leave the server running after verification unless the user asked for a
try-it URL.

## Codex Browser Verification

Use the Codex browser / agent-browser for browser-visible checks. Verify the
smallest set of pages affected by the change.

Default pages:

- `http://localhost:8080/`
- `http://localhost:8080/support.html`
- `http://localhost:8080/privacy.html`
- `http://localhost:8080/terms.html`

Minimum browser evidence:

1. Open each affected page.
2. Check for browser console errors.
3. Verify the changed content or interaction is visible.
4. Verify navigation links that reach or leave the changed surface.
5. Check one desktop viewport and one mobile viewport when CSS/layout changed.
6. Capture or describe any visible issue before fixing it.

## Static Smoke Checks

Use command-line checks when they prove something browser automation does not:

```bash
curl -I http://localhost:8080/
curl -I http://localhost:8080/privacy.html
curl -I http://localhost:8080/terms.html
curl -I http://localhost:8080/support.html
```

Expected result for public pages is `200 OK`.

## Reporting Evidence

In the final response, state:

- local URL or public URL checked;
- pages checked;
- viewport coverage when layout changed;
- whether browser console errors were present;
- any checks skipped and why.
