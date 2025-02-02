import  {prefectureMapping, convertPrefectureName} from "./prefecuture.js"
document.addEventListener("turbo:load", () => {

const user = gon.set_user
      const userName = user.name
      const now = new Date();
      const formatter = new Intl.DateTimeFormat('ja-JP', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
      });
    // _form内でWeatherAPIにfetchする処理
    document.getElementById("city-input").addEventListener("change", (event) =>{
      const cityName = event.target.value;
      const convertCity = convertPrefectureName(cityName);  // :cityの値を漢字から英語へ変換
      fetch(`/weather/show/?city=${encodeURIComponent(convertCity)}`)
        .then(response => response.json())
        .then(data => {
          console.log("取得した天気データ:", data);
          document.getElementById("description").value = data.description;
          document.getElementById("weather_name").value = data.name;
          document.getElementById("temperature").value = data.temp_celsius;
          document.getElementById("temp_max").value = data.temp_max_celsius;
          document.getElementById("temp_min").value = data.temp_min_celsius;
          document.getElementById("pressure").value = data.pressure;
          document.getElementById("weather_icon").value = data.weather_icon;

          // WeatherIconのurlから末尾のn(ダーク)を削除してd（ライト）を追加する処理
          const iconCode = data.weather_icon;
          const weatherIcon = iconCode.slice(0, -1) + "d";
          let pressureAverage = 1013
          const pressureStatus = pressureAverage > 1013 ? "気圧が高まってます!!" : "気圧が低下しています!!";

          document.getElementById("display-weather").innerHTML = `
          <div class="bg-blue-100 p-4 rounded-lg shadow-lg max-w-sm mx-auto ">
                    <div class="preview_header">
                      <h1 class="font-bold text-lg">${data.name}の天気の様子</h1>
                      <h1 class="text-lg font-bold">${userName}さんのプレビュー画面<span class="text-sm">~選択した情報が表示されます~</span></h1>
                    </div>
                    <div class="flex items-center justify-between">
                      <h2 class="text-lg font-bold text-gray-800">${data.name}</h2>
                      <p class="text-sm text-gray-600 font-bold">${formatter.format(now).replace(/\//g, '/')}</p>
                    </div>
                <div class="flex items-center justify-center mt-3">
                    <div class="class="w-32 h-32 mx-auto">
                      <img src="https://openweathermap.org/img/wn/${weatherIcon}@2x.png" alt="天気アイコン">
                    </div>
                    <div class="text-center ml-6">
                      <h2 class="text-lg font-bold">天気: ${data.description}</h2>
                      <p class="text-md">気温: ${data.temp_celsius}°C</p>
                    </div>
                </div>
                <div class="mt-4 border-t-2 pt-2 flex items-stretch justify-center gap-2 ">
                  <div>
                    <p class="text-sm"><strong>最低:</strong> ${data.temp_min_celsius}°C / <strong>最高:</strong> ${data.temp_max_celsius}°C</p>
                    <p class="text-md text-red-400"><strong>気圧:</strong> ${data.pressure}hPa / ${pressureStatus}</p>
                  </div>
                  <div>
                    <p class="text-xs animate-pulse whitespace-nowrap">選んだカラーボール</p>
                    <div id="display-color"></div>
                  </div>
                </div>
          </div>`;
        })
        .catch(error => console.log("天気データのエラー:", error));
    });

    // _formの選択したcolor-idを隠しフィールドに含める処理
  document.querySelectorAll('.color-ball').forEach(function(ball){
    ball.addEventListener('click', function(){
      const colorId = this.getAttribute('data-color-id');
      document.getElementById('color_name').value = colorId;
      const colorMapping = gon.color_mapping;
      const selectedColor = colorMapping[colorId] || "bg-gray-500";
      const previewColor =  document.getElementById("display-color")

      previewColor.className = `rounded-full w-16 h-16 mt-4 animate-bounce mx-auto shadow-lg ${selectedColor}`;

    });
  });
});
