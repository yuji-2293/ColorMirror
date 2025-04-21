import Chart from "chart.js/auto"

document.addEventListener("turbo:load", () => {
  const labels = ["ホッと", "ワクワク", "その他", "モヤモヤ", "ムカムカ"];
  const scores = [50,50,50,50,50]; // 初期はゼロで見せる

    const map = document.getElementById("myChart");
    if (map) {
      const myChart = new Chart(map, {
          type: "radar",
          data: {
            labels: labels,
            datasets: [
              // 理想値のレーダーチャート
              {
              label: "理想の気分",
              data: scores,
              backgroundColor: "rgba(255, 99, 132, 0.1)",
              borderColor: "rgba(255, 99, 132, 1)",
              borderDash: [5, 5],
              pointRadius: 0
              },

              // 実際のfetchしたレーダーチャート

            ]
          },

          // ここに設定オプションを書きます
          options: {
            scales: {
              r: {
                  angleLines: {
                      display: false
                  },
                  suggestedMin: 10,
                  suggestedMax: 50
              }
          }
          }
      });
    // 次にデータを非同期で追加
    fetch("/radar_map")
      .then(response => response.json())
      .then(data => {
        const fetchScores = data.map(entry => entry.score);
        console.log(data);

        myChart.data.datasets.push({
          label: "あなたの気分スコア",
          data: fetchScores,
          backgroundColor: "rgba(70, 180, 220, 0.4)", // 少し濃い＋透明度下げる
          borderColor: "#46B4DC" // 濃いスカイブルーのhex
        });

        myChart.update(); // 再描画！
      });



    }


});
