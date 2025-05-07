module OnomatopeiaHelper
  def self.mood_for_icon(mood)
    case mood
    when "ホッと" then "😊"
    when "ワクワク" then "😁"
    when "わからない" then"🤔"
    when "モヤモヤ" then "😮‍💨"
    when "ムカムカ" then "😬"
    end
  end
end
