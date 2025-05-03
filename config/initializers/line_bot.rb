require "line/bot"

LINE_MESSAGING_CLIENT = Line::Bot::Client.new { |config|
  config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
  config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
}
