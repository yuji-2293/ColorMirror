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
      navigation: {
        nextEl: '.swiper-button-next-custom',
        prevEl: '.swiper-button-prev-custom',
      },
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
