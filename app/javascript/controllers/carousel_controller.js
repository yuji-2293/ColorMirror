import Carousel from "@stimulus-components/carousel";
import Swiper from "swiper";
import "swiper/css/bundle"

export default class extends Carousel {
  static targets = ["slide"]

  connect() {
    super.connect()
    console.log("carouselControllerと接続しました")

    // The swiper instance.
    this.swiper = new Swiper(this.element, {
      loop: false,
      slidesPerView: 1,
      centeredSlides: true,
      navigation: {
        nextEl: '.swiper-button-next-custom',
        prevEl: '.swiper-button-prev-custom',
      },
    });

    this.swiper.on("slideChangeTransitionEnd", () => {
      console.log("スライドが切り替わりました (Stimulus)");

      if (this.swiper.activeIndex === 1) {
        const weather = document.getElementById("description")?.value || "不明";
        const mood = document.getElementById("selected-mood")?.value || "未選択";
        const confirmation = document.getElementById("display-confirmation");

        confirmation.innerHTML = `
          <div id="confirmationCard" class="max-w-3xl h-[300px] mx-auto bg-base-300 flex flex-col rounded-xl shadow-lg overflow-hidden animate-fade-in">
            <div class="container flex items-center justify-around w-full h-full">

              <div class="leftColumn">
                <div class="uppercase tracking-wide text-white font-bold flex flex-col space-y-2">
                  <p class="">今日の天気</p>
                  <p class="lg:text-6xl md:text-4xl sm:text-2xl text-xl">
                    <span id="weather-location">${weather}</span>
                  </p>
                </div>
              </div>

              <div class="text-white text-5xl font-bold">×</div>

              <div class="rightColumn">
                <div class="uppercase tracking-wide text-white font-bold flex flex-col space-y-2">
                <p class="">今日の気分</p>
                <p class="lg:text-6xl md:text-4xl sm:text-2xl text-xl">${mood}</p>
                </div>
              </div>

            </div>
          </div>
        `;
        const fixCard = document.getElementById("confirmationCard");
        fixCard.classList.add("animate-fade-in");
      } else {
        document.getElementById("display-confirmation").innerHTML = "";
      }
    });

    // Default options for every carousels.
    this.defaultOptions
  }

  // You can set default options in this getter.
  get defaultOptions() {
    return {
      // Your default options here
    }
  }
}
