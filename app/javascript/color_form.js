import  {prefectureMapping, convertPrefectureName} from "./prefecuture.js"
document.addEventListener("turbo:load", () => {

    // _form内でWeatherAPIにfetchする処理
    const cityInput = document.getElementById("city");
    if (cityInput){
        console.log("City input change:", cityInput.value);

        if (typeof convertPrefectureName !== "function") {
          console.error("convertPrefectureName が見つかりません。関連ファイルを再確認!!");
          return;
        }

    const cityName = cityInput.value;
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
            document.getElementById("weather_pressure").value = data.pressure;
            document.getElementById("weather_icon").value = data.weather_icon;
            document.getElementById("city").value = cityName;
            const pressure_message = data.pressure_message;

    // WeatherIconのurlから末尾のn(ダーク)を削除してd（ライト）を追加する処理
    const iconCode = data.weather_icon;
    const weatherIcon = iconCode.slice(0, -1) + "d";

            document.getElementById("display-weather").innerHTML = `
            <div id="weather-card" class="max-w-md mx-auto bg-white rounded-xl shadow-lg overflow-hidden md:max-w-2xl border border-gray-200">
              <div class="md:flex">
                <div class="md:flex-shrink-0 flex items-center justify-center bg-blue-100 p-4">
                <img src="https://openweathermap.org/img/wn/${weatherIcon}@2x.png" alt="天気アイコン" class="w-20 h-20 my-auto">
                </div>
                <div class="p-6">
                  <div class="uppercase tracking-wide text-lg text-blue-500 font-semibold">
                    <span id="weather-location">${data.name}</span> の天気
                  </div>
                  <p class="mt-1 text-lg font-bold text-gray-900">
                    <span id="weather-description">${data.name}:${data.description}</span>
                  </p>
                  <p class="text-gray-500 text-sm mt-2">
                    <span id="current-date"></span>
                  </p>
                  <div class="mt-3 flex justify-between">
                    <p class="text-3xl font-bold text-gray-900">
                      <span id="temperature">${data.temp_celsius}</span>°C
                    </p>
                    <div class="text-sm text-gray-600">
                      <p>最低: <span id="temp-min">${data.temp_min_celsius}</span>°C / 最高: <span id="temp-max">${data.temp_max_celsius}</span>°C</p>
                      <p class="mt-1 text-red-500">気圧: <span id="pressure">${data.pressure}</span> hPa</p>
                      <h3 class="text-red-500 font-bold">${pressure_message}</h3>
                    </div>
                  </div>
                </div>
              </div>
            </div>`;

    const now = new Date();
    const formatter = new Intl.DateTimeFormat('ja-JP', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    });
          document.getElementById("current-date").textContent = formatter.format(now).replace(/\//g, "/");
          const weatherCard = document.getElementById("weather-card");
          weatherCard.classList.add("animate-fade-in");
        })
        .catch(error => console.log("天気データのエラー:", error));
    }

    // _formの選択したcolor-idを隠しフィールドに含める処理
  document.querySelectorAll('.color-ball').forEach(function(ball){
    ball.addEventListener('click', function(){
      const colorId = this.getAttribute('data-color-id');
      console.log(colorId);
      document.getElementById('color_name').value = colorId;
      const colorMapping = gon.color_mapping;
      const selectedColor = colorMapping[colorId] || "bg-gray-500";
      const previewColor =  document.getElementById("display-color")
      if (previewColor){
        previewColor.className = `rounded-full w-16 h-16 mt-4 animate-bounce mx-auto shadow-lg ${selectedColor}`;
      }
    });
  });
});
