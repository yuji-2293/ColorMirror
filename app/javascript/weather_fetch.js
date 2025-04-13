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
            // 各データをform_withの隠しフィールドにセット
            document.getElementById("description").value = data.description;
            document.getElementById("weather_name").value = data.name;
            document.getElementById("temperature").value = data.temp_celsius;
            document.getElementById("temp_max").value = data.temp_max_celsius;
            document.getElementById("temp_min").value = data.temp_min_celsius;
            document.getElementById("weather_pressure").value = data.pressure;
            document.getElementById("weather_icon").value = data.weather_icon;
            document.getElementById("city").value = cityName;
            // railsから渡ってきたhelperの定義メッセージを変数に格納
            const pressure_message = data.pressure_message;
            // railsから渡ってきたhelperで変換した画像urlを変数に格納
            const weatherImage = data.weather_image;
            // WeatherIconのurlから末尾のn(ダーク)を削除してd（ライト）を追加する処理
            const iconCode = data.weather_icon;
            const weatherIcon = iconCode.slice(0, -1) + "d";

            // 天気カードを生成
            document.getElementById("display-weather").innerHTML = `
<div id="weather-card" class="max-w-3xl h-[500px] mx-auto glass neumorphism flex flex-col  rounded-xl shadow-lg overflow-hidden">
<div class="container flex items-center justify-around w-full h-full">
<div class="leftColumn">
<div class="uppercase tracking-wide text-white font-bold flex flex-col space-y-2">
<p class="text-6xl"><span id="weather-location">${data.name}</span></p>
<p class="text-sm">現在の日時:<span id="current-date"></span></p>
</div>
<div class="flex flex-col justify-start items-center space-y-2">
<img src="https://openweathermap.org/img/wn/${weatherIcon}@2x.png" alt="天気アイコン" class="w-70 h-70">
<p class="mt-1 text-lg font-bold text-gray-900"><span id="weather-description">${data.description}</span></p>
</div>

</div>

<div class="rightColumn">
<p class="text-7xl font-bold text-white"><span id="temperature">${data.temp_celsius}</span>°C</p>
<p class="text-xl text-white tracking-wide ">
<span id="temp-min" class="text-sky-500">${data.temp_min_celsius}</span>°C<i class="fa-solid fa-temperature-arrow-down fa-fade mr-1" style="color: #1aacf4;"></i>
  /
<span id="temp-max" class="text-rose-500">${data.temp_max_celsius}</span>°C<i class="fa-solid fa-temperature-arrow-up fa-fade ml-1" style="color: #ed0707;"></i>
</p>
</div>

</div>
                <div class="border border-dashed text-white font-bold p-3 rounded-xl">
                <p>~備考~</p>
                <div>
                    <p class="">気圧: <span id="pressure">${data.pressure}</span> hPa<i class="fa-solid fa-signal fa-beat-fade text-xl px-2" style="color: #74C0FC;"></i></p>
                    <strong><p class="">${pressure_message}</p></strong>
                    </div>

                </div>
            </div>
            `;
    // current-dataにformatした日時を格納
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

    // 格納した変数から天気の情報をもとに天気カードの背景を動的に変更
    const step1 = document.getElementById("STEP1");
    if (step1) {
      step1.style.backgroundImage = `url('${weatherImage}')`;
      step1.classList.remove("glass");
      step1.classList.add("bg-cover", "bg-center");
    }
    // 動的に生成した天気カードにtailwindcssで定義したアニメーションを付与
      const weatherCard = document.getElementById("weather-card");
      weatherCard.classList.add("animate-fade-in");
    })
    .catch(error => console.log("天気データのエラー:", error));
    }
});
