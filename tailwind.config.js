module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark", "valentine", "winter"],
    darkTheme: false, // ダークモードをONにする場合は削除
  },
    corePlugins: {
    preflight: false, // TailwindのリセットCSSを無効化
  },
}
