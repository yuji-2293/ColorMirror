import CalHeatmap from "cal-heatmap";

document.addEventListener("turbo:load", () => {
fetch("/heatmap")
.then((response) => response.json())
.then ((data) => {

    const parsedData = data.map(entry => ({
        x: entry.x,
        y:entry.y
    }));

    console.log(parsedData);

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
                            domain: [0, 10, 20, 30, 40],
                            range: ["#B3E5FC", "#DC143C", "#8888ff", "#FFD700", "#02f346"]
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
})

});
