import Chart from "chart.js/auto"

document.addEventListener("turbo:load", () => {
console.log("analysis.jsファイルがロードされました");

const ctx = document.getElementById("myChart");
if (ctx) {
const myChart = new Chart(ctx, {
    type: "radar",
    data: {
      labels: ["怒", "哀", "喜", "楽"],
      datasets: [{
        label: "今日の気分",
        data: [10, 20, 30, 40],
        backgroundColor: "rgba(255, 99, 132, 0.2)",
        borderColor: "rgba(255, 99, 132, 1)"
        }]
    },

    // ここに設定オプションを書きます
    options: {}
});
}



});
