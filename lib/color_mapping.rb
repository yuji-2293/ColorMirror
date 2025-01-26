module ColorMapping
  COLOR_MAPPING = {
    1 => "bg-red-500",
    2 => "bg-orange-500",
    3 => "bg-yellow-500",
    4 => "bg-green-500",
    5 => "bg-blue-500",
    6 => "bg-purple-500",
    7 => "bg-gray-500"
  }.freeze

  PROMPT_MAPPING = {
    1 => "赤",
    2 => "橙",
    3 => "黄色",
    4 => "緑",
    5 => "青",
    6 => "紫",
    7 => "灰色"
}.freeze

    # マッピングを取得するメソッド
    def self.color_class(color_name)
      COLOR_MAPPING[color_name.to_i] || "bg-gray-500" # 無効な値の場合はデフォルトで"bg-gray-500"
    end

    def self.mapping_color(color_id)
      PROMPT_MAPPING[color_id.to_i] || "その他の色"
    end

end
