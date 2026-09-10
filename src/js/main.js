// Locus Bodyworks — progressive-enhancement AJAX submit for the Netlify contact form.
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('form[data-netlify-ajax]').forEach((form) => {
    const status = form.querySelector('.form-status');
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const data = new FormData(form);
      fetch('/', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams(data).toString(),
      })
        .then(() => {
          form.reset();
          if (status) status.hidden = false;
        })
        .catch(() => {
          form.submit();
        });
    });
  });
});
