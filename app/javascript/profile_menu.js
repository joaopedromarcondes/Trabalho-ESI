;(function(){
  function initProfileMenu() {
    const dropdown = document.querySelector('.profile-dropdown');
    if (!dropdown) return;

    const toggle = dropdown.querySelector('.profile-toggle');
    const menu = dropdown.querySelector('.profile-menu');
    if (!toggle || !menu) return;
    toggle.setAttribute('aria-haspopup', 'true');
    toggle.setAttribute('aria-expanded', 'false');
    menu.setAttribute('role', 'menu');
    menu.setAttribute('aria-hidden', 'true');

    function closeMenu() {
      dropdown.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
      menu.setAttribute('aria-hidden', 'true');
    }

    function openMenu() {
      dropdown.classList.add('open');
      toggle.setAttribute('aria-expanded', 'true');
      menu.setAttribute('aria-hidden', 'false');
      const first = menu.querySelector('a, button');
      if (first) first.focus();
    }

    toggle.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      if (dropdown.classList.contains('open')) {
        closeMenu();
      } else {
        openMenu();
      }
    });

    document.addEventListener('click', function(e) {
      if (!dropdown.contains(e.target)) {
        closeMenu();
      }
    });

    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        closeMenu();
        toggle.focus();
      }
    });
    menu.addEventListener('keydown', function(e) {
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initProfileMenu);
  } else {
    initProfileMenu();
  }
})();