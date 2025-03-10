import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal"]
    connect() {
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
