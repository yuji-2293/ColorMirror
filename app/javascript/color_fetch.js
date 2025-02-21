  //   // _formの選択したcolor-idを隠しフィールドに含める処理
  // document.querySelectorAll('.color-ball').forEach(function(ball){
  //   ball.addEventListener('click', function(){
  //     const colorId = this.getAttribute('data-color-id');
  //     console.log(colorId);
  //     document.getElementById('color_name').value = colorId;
  //     const colorMapping = gon.color_mapping;
  //     const selectedColor = colorMapping[colorId] || "bg-gray-500";
  //     const previewColor =  document.getElementById("display-color")
  //     if (previewColor){
  //       previewColor.className = `rounded-full w-16 h-16 mt-4 animate-bounce mx-auto shadow-lg ${selectedColor}`;
  //     }
  //   });
  // });

document.addEventListener("turbo:load", ()=>{
  const moodButtons = document.querySelectorAll(".mood-button");
  const selectedMoodInput = document.getElementById("selected-mood");
  const generateColorsButton = document.getElementById("generate-colors");
  const colorSuggest = document.getElementById("color-suggest");
  const otherMoodButton = document.getElementById("other-mood-button");
  const otherMoodInput = document.getElementById("other-mood-input");
  const otherMoodInputContainer = document.getElementById("other-mood-input-container");

  moodButtons.forEach(button => {
    button.addEventListener("click", () => {
      moodButtons.forEach(btn => btn.classList.remove("ring-2", "ring-error"));

      if(button === otherMoodButton) {
        otherMoodInputContainer.classList.remove("hidden");
        otherMoodInput.focus();
        selectedMoodInput.value = "";
      }else {
        otherMoodInputContainer.classList.add("hidden");
        button.classList.add("ring-2", "ring-error");

        selectedMoodInput.value = button.dataset.mood;
        console.log(selectedMoodInput.value);
      };
    });
  });
    if (otherMoodInput){
      otherMoodInput.addEventListener("input", () => {
        selectedMoodInput.value = otherMoodInput.value;
        console.log(selectedMoodInput.value);
      });
    };


  generateColorsButton.addEventListener("click", () => {
    const mood = selectedMoodInput.value;
    if (!mood) {
      alert("気分を選んでください");
      return;
    }
    fetch("/colors/analyze", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ mood })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      colorSuggest.innerHTML = "";
      data.colors.forEach(color => {
        const colorBall = document.createElement("div");
        colorBall.classList.add("w-20", "h-20", "rounded-full", "cursor-pointer", "shadow-lg","transition", "hover:scale-110");
        colorBall.style.backgroundColor = color.hex;
        colorBall.dataset.color = color.hex;

        // ラベルの作成
        const colorLabel = document.createElement("p");
        colorLabel.textContent = color.name;
        colorLabel.classList.add("text-xs", "text-gray-700", "mt-1", "text-center");
        console.log(colorLabel);

        const colorContainer = document.createElement("div");
        colorContainer.appendChild(colorBall);
        colorContainer.appendChild(colorLabel);
        colorSuggest.appendChild(colorBall);
        colorSuggest.appendChild(colorContainer);

  });
  const AnimateColor = document.getElementById("color-suggest");
  AnimateColor.classList.add("animate-fade-in");
})
.catch(error => console.log("エラー:", error));
});
});

document.addEventListener("turbo:load", () => {
  const moodCards = document.querySelectorAll(".flip-card");
  const selectedMoodInput = document.getElementById("selected-mood");

  moodCards.forEach(card => {
    card.addEventListener("click", () => {
      // すべてのカードの回転をリセット
      moodCards.forEach(btn => btn.classList.remove("flipped"));

      // クリックしたカードを回転
      card.classList.add("flipped");

      // hidden input に選択した気分をセット
      selectedMoodInput.value = card.dataset.mood;
    });
  });
});
