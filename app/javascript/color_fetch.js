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
  const generateColorsButton = getElementById("generate-colors");
  const colorSuggest = getElementById("color-suggest");

  moodButtons.forEach(button => {
    button.addEventListener("click", () => {
      moodButtons.forEach(btn => btn.classList.remove("ring-4", "ring-yellow-500"));

      button.classList.add("ring-4", "ring-yellow-500");

      selectedMoodInput.value = button.dataset.mood;
      console.log("選択した気分");
    })
  })
})
