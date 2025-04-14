import CalHeatmap from 'cal-heatmap';


document.addEventListener("turbo:load", () => {
    const cal = new CalHeatmap();
    const cellSize = 50
    cal.paint(
        {
            itemSelector: document.getElementById("cal-heatmap"),
            //or itemSelector: document.getElementById("cal-heatmap"),

            domain: {
                type: "month",
                gutter: 8,
                label: {
                    text: "MMM",
                    textAlign: "start",
                    position: "top"
                }
            },
            subDomain: {
                type:"ghDay",
                gutter:6,
                width:cellSize,
                height:cellSize,
                radius:cellSize,
            },
            date: {
                start: new Date("2024-04-14")
            },
            range: 12,
            data: {
                source: "data.json",
                x: "date",
                y: "total"
            },
            scale: {
                color: {
                    type: "linear",
                    range: ["#ededed","#4dd05a","#37a446","#166b34"],
                    domain: [0,10,20,30],
                }
            }
        }
    );
});
