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
      animation: {
        "fade-in": "fadeIn 1s ease-in-out",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: 0, transform: "translateY(-10px)" },
          "100%": { opacity: 1, transform: "translateY(0)" },
        },
      },
      backgroundImage: {
        "gradient-diagonal": "linear-gradient(135deg, #f472b6 0%, #ffffff 50%, #7dd3fc 100%)",
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
    darkTheme: false, // ダークモードをONにする場合は削除
  },
  //   corePlugins: {
  //   preflight: false, // TailwindのリセットCSSを無効化
  // },
}
