class AiColorService
  def self.generate_color(mood)
    prompt = "ユーザーが今感じている気分は'#{ mood }' です。この気分に最適なカラーコードを4つ提案してください。#で始まるHEXカラーコードを使ってください"

    response  = ::ColorResponseService.new.fetch_response(prompt)
    content = response["choices"][0]["message"]["content"]
    colors = content.scan(/#(?:[0-9a-fA-F]{3}){1,2}/) # HEXカラーコードを抽出
    colors.uniq.first(4)
  end
end
