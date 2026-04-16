/* Scroll-triggered fade-in animations — used on every page */
const obs = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.07 });
document.querySelectorAll('.fade-up').forEach(el => obs.observe(el));
