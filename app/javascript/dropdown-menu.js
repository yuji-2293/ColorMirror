  // Get the checkbox and dropdown menu
  const menuToggle = document.getElementById('menu-toggle');
  const dropdownMenu = document.getElementById('dropdown-menu');

  // Toggle dropdown menu visibility
  menuToggle.addEventListener('change', () => {
    if (menuToggle.checked) {
      dropdownMenu.classList.remove('hidden'); // Show menu
    } else {
      dropdownMenu.classList.add('hidden'); // Hide menu
    }
  });
