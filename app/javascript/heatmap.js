import CalHeatmap from "cal-heatmap";

document.addEventListener("turbo:load", () => {
    const painHeatmap = document.getElementById("cal-heatmap");
    if (painHeatmap){
        fetch("/heatmap")
        .then((response) => response.json())
        .then ((data) => {

            const parsedData = data.map(entry => ({
                x: entry.x,
                y: entry.y
            }));

            console.log(parsedData);
            // parsedData が存在する時heatmapを描画する
            if (parsedData) {
                    const cal = new CalHeatmap();
                    const cellSize = 30
                    const radius = 10
                    cal.paint(
                        {
                            itemSelector: document.getElementById("cal-heatmap"),
                            //or itemSelector: document.getElementById("cal-heatmap"),

                            domain: {
                                type: "month",
                                gutter: 15,
                                label: {
                                    text: "MMM",
                                    textAlign: "start",
                                    position: "top"
                                },
                            },
                            subDomain: {
                                type:"ghDay",
                                gutter:3,
                                width:cellSize,
                                height:cellSize,
                                radius:radius,

                            },
                            date: {
                                start: new Date()
                            },
                            range: 12,
                            data: {
                            source: parsedData,
                            x: "x",
                            y: "y"
                            },

                            scale: {
                                color: {
                                    type: "linear",
                                    domain: [0, 1, 2, 3, 4, 5],
                                    range: ["#fff9","#DC143C", "#8888ff","#B3E5FC", "#FFD700", "#02f346"]
                                }
                            },

                        },
                        [
                            [
                                CalendarLabel,
                                {
                                position: "left",
                                key: "left",
                                text: () => ["Sun", "Mon", "", "wed", "", "fri", ""],
                                textAlign: "end",
                                width: 30,
                                padding: [5, 5, 5, 5],
                                },
                            ],
                        ],
                    );
            }
        })
        .catch(err => {
            console.log(err);
            // エラー処理をちゃんと書く（モーダル出すとか）
        });
    }
});
