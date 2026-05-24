import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const src = path.join(root, "src");

const partial = async (name) => readFile(path.join(src, "partials", name), "utf8");
const pageFragment = async (name) => readFile(path.join(src, "pages", `${name}.html`), "utf8");

const render = (template, values) =>
  template.replace(/\{\{(\w+)}}/g, (_, key) => values[key] ?? "");

const indent = (value, spaces = 2) => {
  const prefix = " ".repeat(spaces);
  return value
    .trim()
    .split("\n")
    .map((line) => (line.length > 0 ? `${prefix}${line}` : ""))
    .join("\n");
};

const compactBlankLines = (value) => value.replace(/\n{3,}/g, "\n\n").trim();

const pages = [
  {
    name: "index",
    output: "index.html",
    title: "Luna",
    description: "Luna is a personal astrology app.",
    bodyClass: "home-page",
    stylesheetHref: "style.css?v=20260524-22",
    scripts: '<script src="scripts/home.js"></script>',
  },
  {
    name: "privacy",
    output: "privacy.html",
    title: "Privacy Policy - Taia",
    description: "Privacy Policy for the Taia mobile app.",
    bodyClass: "legal-page",
  },
  {
    name: "terms",
    output: "terms.html",
    title: "Terms of Service - Taia",
    description: "Terms of Service for the Taia mobile app.",
    bodyClass: "legal-page",
  },
  {
    name: "about",
    output: "about.html",
    title: "About - Taia",
    description: "About Taia.",
    bodyClass: "content-page",
  },
  {
    name: "contact",
    output: "contact.html",
    title: "Contact - Taia",
    description: "Contact Taia.",
    bodyClass: "content-page",
  },
  {
    name: "jobs",
    output: "jobs.html",
    title: "Jobs - Taia",
    description: "Jobs at Taia.",
    bodyClass: "content-page",
  },
  {
    name: "support",
    output: "support.html",
    title: "Support - Taia",
    description: "Support for the Taia mobile app.",
    bodyClass: "content-page",
  },
];

const [headTemplate, headerTemplate, footerTemplate, footerCtaTemplate] =
  await Promise.all([
    partial("head.html"),
    partial("header.html"),
    partial("footer.html"),
    partial("footer-cta.html"),
  ]);

await mkdir(root, { recursive: true });

for (const page of pages) {
  const content = (await pageFragment(page.name)).trim();
  const head = render(headTemplate, {
    title: page.title,
    description: page.description,
    stylesheetHref: page.stylesheetHref ?? "style.css",
  });
  const footer = render(footerTemplate, {
    footerCta: `${footerCtaTemplate.trim()}\n\n`,
  });
  const scripts = page.scripts ? `\n${indent(page.scripts, 4)}` : "";
  const html = `<!doctype html>
<html lang="en">
${indent(head)}
  <body id="top" class="${page.bodyClass}">
${indent(headerTemplate, 4)}

${indent(content, 4)}

${indent(compactBlankLines(footer), 4)}${scripts}
  </body>
</html>
`;

  await writeFile(path.join(root, page.output), html, "utf8");
  console.log(`Built ${page.output}`);
}
