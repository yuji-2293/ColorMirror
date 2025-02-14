// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./color_form"
import "./prefecuture"

document.addEventListener("turbo:load", () => {
// flash_messageが表示されたら3秒かけて消えていく
document.querySelectorAll(".alert").forEach((element) => {
    setTimeout(() => {
        element.style.transition = "opacity 1s";
        element.style.opacity = "0";
        setTimeout(() => {
            element.style.visibility = "hidden";
        }, 1000);
        }, 3000)
    });
});
