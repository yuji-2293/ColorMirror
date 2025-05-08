document.addEventListener("turbo:load", ()=>{
  const moodButtons = document.querySelectorAll(".mood-button");
  const selectedMoodInput = document.getElementById("selected-mood");
  const selectedWeatherInput = document.getElementById("description");  // 天気APから取得した天気情報を取得
  const generateColorsButton = document.getElementById("generate-colors");
  const colorSuggest = document.getElementById("color-suggest");

  moodButtons.forEach(button => {
    button.addEventListener("click", () => {
if (selectedMoodInput) {
        selectedMoodInput.value = button.dataset.mood;
        console.log(selectedMoodInput.value);
        console.log(selectedWeatherInput.value);
      }
    });
  });

if (generateColorsButton) {
  generateColorsButton.addEventListener("click", () => {
    const mood = selectedMoodInput.value;
    const weather = selectedWeatherInput.value;
    console.log(weather);
    if (!mood) {
      alert("気分を選んでください");
      return;
    }
    fetch("/colors/analyze", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ mood, weather })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      colorSuggest.innerHTML = "";
      data.colors.forEach(color => {

        // ボールの作成
        const colorBall = document.createElement("div");
        colorBall.classList.add("w-20", "h-20", "rounded-full", "cursor-pointer", "shadow-lg","transition", "hover:scale-110", "color-ball");
        colorBall.style.backgroundColor = color.hex;
        colorBall.dataset.color = color.hex;

        // ラベルの作成
        const colorLabel = document.createElement("p");
        colorLabel.textContent = color.name;
        colorLabel.classList.add("text-md", "text-gray-700", "mt-3", "text-center", "font-bold");
        console.log(colorLabel);

         // コンテナの作成
        const colorContainer = document.createElement("div");
        colorContainer.classList.add("flex", "flex-col", "items-center","justify-center");

        colorContainer.appendChild(colorBall);
        colorContainer.appendChild(colorLabel);

        colorSuggest.appendChild(colorContainer);
      });
      const AnimateColor = document.getElementById("color-suggest");
      AnimateColor.classList.add("animate-fade-in");
      setupColorBallClickEvents();
})
.catch(error => console.log("エラー:", error));
});
};


// カード選択イベントの処理
  const moodCards = document.querySelectorAll(".flip-card");
  moodCards.forEach(card => {
    card.addEventListener("click", () => {
      // すべてのカードの回転をリセット
      moodCards.forEach(btn => btn.classList.remove("flipped"));

      // クリックしたカードを回転
      card.classList.add("flipped");

    });
  });

// 動的に生成されたカラーボールにクリックイベントを追加する関数（ハイライトを追加）
  function setupColorBallClickEvents() {
    let clickedButton = null;
    const submitColor =  document.querySelectorAll('.color-ball');

    submitColor.forEach(submit => {
      submit.addEventListener("click", (event) => {
      const newClickedButton = event.target

      if ( clickedButton && clickedButton !== newClickedButton) {
        clickedButton.classList.remove("ring-4", "scale-125"); // 以前のボタンのクラスを削除
      }

      if (clickedButton === newClickedButton) {
        return;
      }
      clickedButton = newClickedButton;
      clickedButton.classList.add("ring-4", "scale-125");

        const colorName = window.getComputedStyle(event.target).backgroundColor;
        console.log(colorName);
        document.getElementById("color_name").value = colorName;

      });
    });
  }
  setupColorBallClickEvents();
  });
