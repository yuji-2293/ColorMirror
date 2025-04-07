import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="step-form"
export default class extends Controller {
  static targets = ["step"]

  connect() {
    this.currentStep = 1;
    this.showCurrentStep();
  }

  showCurrentStep() {
    this.stepTargets.forEach((stepElement, index) => {

      if (index === this.currentStep - 1) {
        stepElement.style.display = "block";
      }else {
        stepElement.style.display = "none";
      }
    });
  }

  ColorMirrorのformに合わせてバリデーションを設定する
  validateCurrentStep() {
    const currentStepElement = this.stepTargets[this.currentStep - 1];
    // 現在表示されているステップの要素を取得します。

    const hiddenGroups = currentStepElement.querySelectorAll('input[type="hidden"]');
    // 現在のステップ内にあるラジオボタンを全て取得します。

    let isValid = false;
    // 選択肢が選ばれているかどうかを判定するための変数です。
    // 最初は "false" に設定します（何も選ばれていない状態）。

    hiddenGroups.forEach((hidden) => {

      if (hidden) {
        isValid = true;
        // "isValid" を true に変更します（つまり、選択されているということです）。
      }
    });

    return isValid;
    // 最終的に、このステップでラジオボタンが選ばれているかどうかを返します。
  }


  nextStep() {
    if (this.validateCurrentStep()) {
      if (this.currentStep < this.stepTargets.length) {
        this.currentStep++;

        this.showCurrentStep();

      }
    } else {
      alert("選択してください");
    }
  }

  prevStep() {
    if (this.currentStep > 1) {
      this.currentStep--;

      this.showCurrentStep();
    }
  }
}
