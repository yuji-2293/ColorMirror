import CalHeatmap from "cal-heatmap";

document.addEventListener("turbo:load", () => {
    const painHeatmap = document.getElementById("cal-heatmap");
    const now = new Date();
    const startOfYear = new Date(now.getFullYear(), 0, 1);
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
    const endOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0);

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
                                type:"day",
                                gutter:3,
                                width:cellSize,
                                height:cellSize,
                                radius:radius,

                            },
                            date: {
                                start: new Date(startOfYear)
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
                                    domain: [0, 1, 2, 3],
                                    range: ["#FF5C7A","#191970","#A9A9A9", "#FF8C42" ]
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
                    ).then(() => {
                            const domains = document.querySelectorAll('.ch-domain');
                            domains.forEach((el) => {
                            const className = el.className.baseVal || el.className;
                            const match = className.match(/m_(\d+)/);
                            if (match) {
                                const monthNumber = parseInt(match[1], 10);
                                const now = new Date();
                                const currentMonth = now.getMonth();
                                if (monthNumber - 1 === currentMonth) {
                                el.classList.add('is-current-month');
                                el.scrollIntoView({ behavior: "smooth", block: "center", inline: "center"  }); // ← スクロールでフォーカス
                                el.classList.add("transition-shadow", "duration-500");
                                }
                            }
                            });
                        });

            }
        })
        .catch(err => {
            console.log(err);
            // エラー処理をちゃんと書く（モーダル出すとか）
        });
    }
});
