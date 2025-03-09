// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./color_fetch"
import "./prefecuture"
import "./weather_fetch"

// flash_messageが表示されたら5秒かけて消えていく
document.addEventListener("turbo:load", () => {
console.log("Turboがロードされました");

    const alerts = document.querySelectorAll(".alert");
        alerts.forEach(alert => {
            alert.classList.add("show")
            setTimeout(() => {
                alert.classList.add("hide");
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
    };
document.body.addEventListener("click", (event) =>{
    if (event.target.id === "return-button") {
        const returnTarget = document.getElementById("return");
        if (returnTarget) {
            returnTarget.focus();
            returnTarget.scrollIntoView({ behavior: "smooth", block: "nearest"});
returnTarget.classList.add("ring-4", "ring-yellow-400", "transition-shadow", "duration-500");
        }
    }
});
});

// document.addEventListener("turbo:load", () => {
//     const modal = document.getElementById("password-reset-modal");
//     const closeModal = document.getElementById("close-modal");

//     if (closeModal) {
//         closeModal.addEventListener("click", () => {
//             modal.classList.add("hidden");
//         });
//     }
// });
