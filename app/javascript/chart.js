import Chart from "chart.js/auto"

document.addEventListener("turbo:load", () => {
    const map = document.getElementById("myChart");
    if (map) {
    fetch("/map")
    .then(response => response.json())
    .then(data => {
    const labels = ["日","月", "火", "水", "木", "金", "土"];
    const currentWeekScores = data.current_scores.map(item => item.score);
    const lastWeekScores = data.last_scores.map(item => item.score);
    console.log(data);


      const myChart = new Chart(map, {
          type: "line",
          data: {
            labels: labels,
            datasets: [
              {
                label: '今週',
                data:currentWeekScores,
                fill: true,
                tension: 0.3,
                borderColor: "#FF5C7A",
                pointBackgroundColor: "#FF5C7A",
              },
              {
                label: '先週',
                data:lastWeekScores,
                fill: false,
                tension: 0.3,
                borderColor: "#8fdcfb",
                pointBackgroundColor: "#8fdcfb",
              }
            ]
          },

          // 設定オプション
          options: {
            scales: {
              y: {
                beginAtZero: true,
                suggestedMax: 5
              }
            }
          }
      });
    });


    }

});
