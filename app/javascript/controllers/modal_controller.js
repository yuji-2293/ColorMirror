import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "token", "copyButton"]

    copyToken() {
        navigator.clipboard.writeText(this.tokenTarget.value)
          .then(() => {
                this.copyButtonTarget.innerHTML = '<i class="fas fa-check-circle fa-2xl"></i>'

            setTimeout(() => {
                this.copyButtonTarget.innerHTML =  '<i class="fa-regular fa-copy fa-2xl"></i>';
              }, 2000)
          })
          .catch(() => {
            alert("コピーに失敗しました。");
          })
    }


    open() {
        this.modalTarget.classList.remove("modal-hidden");
        this.modalTarget.classList.add("modal-visible");
    }

    close(event) {
        if (event.target === this.modalTarget.querySelector("[data-action='click->modal#close']")) {
            this.modalTarget.classList.remove("modal-visible");
            this.modalTarget.classList.add("modal-hidden");
            return;
        }

        if (event.target === this.element){
            this.modalTarget.classList.remove("modal-visible");
            this.modalTarget.classList.add("modal-hidden");
        }
    }
}
