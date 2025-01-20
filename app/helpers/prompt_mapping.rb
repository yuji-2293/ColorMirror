module PromptMapping
  PROMPT_MAPPING = {
    1 => "赤",
    2 => "橙",
    3 => "黄色",
    4 => "緑",
    5 => "青",
    6 => "紫",
    7 => "灰色"
}.freeze

  def mapping_color(color_id)
    PROMPT_MAPPING[color_id.to_i] || "その他の色"
  end
end
