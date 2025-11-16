document.addEventListener('DOMContentLoaded', function() {
  function createLightbox(src) {
    const backdrop = document.createElement('div');
    backdrop.className = 'lightbox-backdrop';

    const wrapper = document.createElement('div');
    wrapper.className = 'lightbox-content';

    const img = document.createElement('img');
    img.src = src;
    img.alt = '';

    wrapper.appendChild(img);
    backdrop.appendChild(wrapper);

    // fechar foto ao clicar fora dela em qualquer lugar
    backdrop.addEventListener('click', function(e) {
      if (e.target === backdrop) document.body.removeChild(backdrop);
    });

    // fechar 
    function onKey(e) {
      if (e.key === 'Escape') {
        if (document.body.contains(backdrop)) document.body.removeChild(backdrop);
        document.removeEventListener('keydown', onKey);
      }
    }
    document.addEventListener('keydown', onKey);

    return backdrop;
  }

  document.body.addEventListener('click', function(e) {
    const link = e.target.closest('.photo-link[data-lightbox]');
    if (!link) return;
    e.preventDefault();
    const src = link.dataset.fullSrc || link.querySelector('img')?.src;
    if (!src) return;
    const lb = createLightbox(src);
    document.body.appendChild(lb);
  });
});
