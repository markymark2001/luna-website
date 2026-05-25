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
