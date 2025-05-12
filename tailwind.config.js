const { transform } = require("esbuild");

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        body: "#fffaf0",
        ocean: "#0c4a6e",
      },
      animation: {
        "fade-in": "fadeIn 0.5s ease-in-out",
        "fade-in-text": "fadeInText 0.5s ease-in-out",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: 0, transform: "translateY(-10px)" },
          "100%": { opacity: 1, transform: "translateY(0)" },
        },
        fadeInText: {
          "0%": { opacity: 0, transform: "translateX(-10px)" },
          "100%": { opacity: 1, transform: "translateX(0)" },
        },
      },
      backgroundImage: {
        "gradient-diagonal": "linear-gradient(135deg, #f472b6 0%, #ffffff 50%, #7dd3fc 100%)",
        "footer-gradient-diagonal": "linear-gradient(to right, #7dd3fc, #f472b6 )"
      },
      // font
      fontFamily: {
        // ベース用フォント
        sans: ['"Noto Sans JP"', 'sans-serif'],

        // やわらかい見出し・感情表現など
        rounded: ['"M PLUS Rounded 1c"', 'sans-serif'],

        // マイルドで表情豊かにしたい見出しなど
        maru: ['"Zen Maru Gothic"', 'sans-serif'],

        mincho: ['"Shippori Mincho"', 'Georgia', 'serif'],
      },
    },
  },
  plugins: [require("daisyui"),
    require('tailwindcss'),
    require('autoprefixer'),
    require('postcss-import'), ],
  daisyui: {
    themes: ["light", "dark"],
    darkTheme: false, // ダークモードをONにする場合は削除
  },
}
