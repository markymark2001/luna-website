document.querySelectorAll(".review-track").forEach((track) => {
  const groups = track.querySelectorAll(".review-group");
  const template = groups[1] || groups[0];
  if (!template) return;

  const existing = track.querySelectorAll(".review-group").length;
  for (let i = existing; i < 4; i += 1) {
    const clone = template.cloneNode(true);
    clone.setAttribute("aria-hidden", "true");
    track.appendChild(clone);
  }
});

const header = document.querySelector(".site-header");
const heroCta = document.querySelector(".video-hero__bottom .button");

const syncHeader = () => {
  const ctaHasScrolledOut = heroCta
    ? heroCta.getBoundingClientRect().bottom <= 0
    : window.scrollY > 40;
  header?.classList.toggle("is-visible", ctaHasScrolledOut);
};

syncHeader();
window.addEventListener("scroll", syncHeader, { passive: true });
window.addEventListener("resize", syncHeader);
