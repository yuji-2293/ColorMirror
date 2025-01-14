  // swapボタンのtrue or false をidで取得
  // デフォルトが'hidden'クラスを持つdropdown-menuを取得
  const menuToggle = document.getElementById('menu-toggle');
  const dropdownMenu = document.getElementById('dropdown-menu');

  // Toggle dropdown をswapボタンの変化で開閉させる処理
  menuToggle.addEventListener('change', () => {
    if (menuToggle.checked) {
      dropdownMenu.classList.remove('hidden'); // Show menu
    } else {
      dropdownMenu.classList.add('hidden'); // Hide menu
    }
  });

  // ドロップダウンメニューの外側をクリックしたらメニューが閉じる処理
  document.addEventListener('click', (e) => {
    if (!menuToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
      menuToggle.checked =false;
      dropdownMenu.classList.add('hidden');
    }
  });
