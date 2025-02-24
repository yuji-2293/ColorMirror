// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./color_fetch"
import "./prefecuture"
import "./weather_fetch"

// flash_messageが表示されたら5秒かけて消えていく
document.addEventListener("turbo:load", () => {
document.querySelectorAll(".alert").forEach((element) => {
    setTimeout(() => {
        element.style.transition = "opacity 1s";
        element.style.opacity = "0";
        setTimeout(() => {
            element.style.visibility = "hidden";
        }, 1000);
        }, 5000)
    });
});
// 要素に対してフォーカスを当てスクロールさせる
document.addEventListener("turbo:load", () => {
    const target =  document.getElementById("focus-target");
    if (target) {
        target.focus();
        target.scrollIntoView({ behavior: "smooth", block: "center" });
    }
});
