module ApplicationHelper
  include ColorMapping
    def default_meta_tags
      {
        site: "ColorMirror",
        title: "ColorMirror",
        reverse: true,
        charset: "utf-8",
        description: "気分を色に変換して自己と向き合うセルフケアサービスです（AIと共に）",
        keywords: "感情、天気、色、AI, 傾向、分析",
        canonical: "https://colormirror.jp/",
        separator: "|",
        og: {
          site_name: :site,
          title: :title,
          description: :description,
          type: "website",
          url: "https://colormirror.jp/",
          image: image_url("ogp.png"),
          locale: "ja-JP"
        },
        twitter: {
          card: "summary_large_image",
          site: "@obvyamdrss",
          image: image_url("ogp.png")
        }
      }
    end

    def active_class_by_controller_and_action(controller, action, active_class = "text-white", default_class = "text-ocean")
      base = "hover:scale-[1.1]"
      controller_name == controller && action_name == action ? "#{base} #{active_class}" : "#{base} #{default_class}"
    end
end
