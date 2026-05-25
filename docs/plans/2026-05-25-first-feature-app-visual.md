# First Feature App Visual Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the first homepage phone screenshot with a non-literal Taia app visual made from HTML and CSS.

**Architecture:** Keep the existing Eleventy homepage and iPhone frame. Add one focused Nunjucks partial for the first feature's app-inspired visual, select it through homepage data, and style it in the existing homepage stylesheet so future feature visuals can be added without copying screenshot markup.

**Tech Stack:** Eleventy, Nunjucks, static HTML, CSS gradients, CSS layout, local static server browser verification.

---

### Task 1: Data And Template Selection

**Files:**
- Modify: `src/_data/home.js`
- Modify: `src/pages/index.html`
- Create: `src/_includes/partials/visuals/say-real.njk`

- [x] **Step 1: Mark the first feature visual**

Add `visual: "say-real"` to the first object in `src/_data/home.js`:

```js
{
  title: "Say what’s real",
  copy: "A text you want to send. A person you cannot read. A decision that keeps looping. A low mood, a strange dream, or a question about where your life is heading.",
  visual: "say-real"
}
```

- [x] **Step 2: Render the partial only for the first feature**

Replace the existing repeated phone image block in `src/pages/index.html` with a conditional:

```njk
<figure class="device-frame device-frame--iphone feature-device" aria-label="Taia app feature preview">
  <div class="device-frame__screen">
    {% if feature.visual == "say-real" %}
      {% include "partials/visuals/say-real.njk" %}
    {% else %}
      <img src="/assets/hero-app-screenshot.png" alt="Taia app screenshot">
    {% endif %}
  </div>
</figure>
```

- [x] **Step 3: Add the first visual partial**

Create `src/_includes/partials/visuals/say-real.njk`:

```njk
<div class="app-visual app-visual--say-real" aria-hidden="true">
  <div class="say-real-atmosphere"></div>
  <div class="say-real-status">
    <span>TAIA</span>
    <i></i>
  </div>
  <div class="say-real-thread">
    <div class="say-real-bubble say-real-bubble--user">What do I say without making it worse?</div>
    <div class="say-real-bubble say-real-bubble--assistant">Start with what is true, then name the boundary.</div>
  </div>
  <div class="say-real-composer">
    <span>Type a message...</span>
    <span class="say-real-send" aria-hidden="true"></span>
  </div>
</div>
```

### Task 2: Homepage Visual CSS

**Files:**
- Modify: `public/styles/home.css`
- Modify: `public/styles/responsive.css`

- [x] **Step 1: Add base visual styles**

Add CSS after the existing `.feature-device::after` block in `public/styles/home.css`. Keep the palette aligned with the Flutter app colors: `#150213`, `#DDC9C2`, `#291625`, warm progress/accent colors, and translucent taupe glass.

- [x] **Step 2: Add responsive adjustments**

If mobile screenshots show text crowding, add narrow-width overrides to `public/styles/responsive.css` near the existing device frame rules. Keep all text inside fixed containers and avoid layout shift.

### Task 3: Verification And Publish

**Files:**
- Verify: `dist/index.html`
- Verify: browser path `http://127.0.0.1:<port>/`

- [x] **Step 1: Build**

Run:

```bash
npm run build
```

Expected: Eleventy builds `dist/index.html` without errors.

- [x] **Step 2: Static checks**

Run:

```bash
git diff --check
```

Expected: no whitespace errors.

- [x] **Step 3: Browser evidence**

Serve `dist` locally:

```bash
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

Open `http://127.0.0.1:8080/` in the Codex browser. Verify the first feature phone shows the new app visual, the next three feature phones still show the screenshot, and there are no console errors. Check one desktop viewport and one mobile viewport.

- [x] **Step 4: Review, commit, push, and update PR**

Run the repo review helper if available:

```bash
./.codex/scripts/codex-review.sh
```

Then commit and push the completed implementation on the current branch. Update the existing pull request body if needed.
