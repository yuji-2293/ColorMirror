document.addEventListener('turbo:load', () => {
  // ページ遷移後のJavaScript初期化処理 修正
  const menuToggle = document.getElementById('menu-toggle');
  const dropdownMenu = document.getElementById('dropdown-menu');

  if (menuToggle && dropdownMenu) {
    // menuToggle.addEventListener('change', () => {
    //   if (menuToggle.checked) {
    //     dropdownMenu.classList.remove('hidden');
    //   } else {
    //     dropdownMenu.classList.add('hidden');
    //   }
    // });


    menuToggle.addEventListener('click', (e) => {
      const isClickInside = menuToggle.contains(e.target) || dropdownMenu.contains(e.target);
      if (isClickInside) {
        dropdownMenu.classList.remove('hidden');
        menuToggle.checked = true;
      }else{
        dropdownMenu.classList.add('hidden');
        menuToggle.checked = false;
      }
    });

    document.addEventListener('click', (e) => {
      const isClickInside = menuToggle.contains(e.target) || dropdownMenu.contains(e.target);
      if (!isClickInside) {

        dropdownMenu.classList.add('hidden');
        menuToggle.checked = false;

      }
    });
  }
});
