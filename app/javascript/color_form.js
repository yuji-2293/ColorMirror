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
    const cityInput = document.getElementById("city");

    if (cityInput){
      cityInput.addEventListener("change", (event) =>{
        console.log("City input change:", cityInput.value)
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
            document.getElementById("weather_pressure").value = data.pressure;
            document.getElementById("weather_icon").value = data.weather_icon;
            document.getElementById("city").value = cityName;

            // WeatherIconのurlから末尾のn(ダーク)を削除してd（ライト）を追加する処理
            const iconCode = data.weather_icon;
            const weatherIcon = iconCode.slice(0, -1) + "d";
            let pressureAverage = 1013
            const pressureStatus = pressureAverage > 1013 ? "気圧が高まってます!!" : "気圧が低下しています!!";

            document.getElementById("display-weather").innerHTML = `
                        <div class="bg-blue-100 p-4 rounded-2xl shadow-lg max-w-lg mx-auto flex flex-col items-center justify-center">
                    <div class="preview_header">
                        <h1 class="font-bold">${data.name}の天気の様子</h1>
                        <h3 class="font-bold">${userName}さんの選択プレビュー画面</h3>
                       <p class="text-gray-600 font-bold">${formatter.format(now).replace(/\//g, '/')}</p>
                        ~選択した情報が表示されます~
                    </div>
                    <div class="preview_description grid grid-cols-2 items-center gap-4 mt-1 pb-2">
                        <h2 class="font-bold text-gray-800">${data.name}:  ${data.description}</h2>
                        <div class="class="w-32 h-32 mx-auto">
                            <img src="https://openweathermap.org/img/wn/${weatherIcon}@2x.png" alt="天気アイコン">
                        </div>
                    </div>
                    <div class="mt-1">
                        <div>
                            <p class="text-md">気温: ${data.temp_celsius}°C</p>
                            <p class="text-md text-red-400"><strong>気圧:${data.pressure}hPa / ${pressureStatus}</strong></p>
                        </div>
                        <div>
                            <p class="text-sm"><strong>最低:</strong> ${data.temp_min_celsius}°C / <strong>最高:</strong> ${data.temp_max_celsius}°C</p>
                        </div>
                        <div>
                            <p class="text-base animate-pulse whitespace-nowrap">下の欄からカラーボールを選択後「登録する」を押してください！！</p>
                            <div id="display-color"></div>
                        </div>
                    </div>
                    </div>
            </div>`;
          })
          .catch(error => console.log("天気データのエラー:", error));
      });
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
