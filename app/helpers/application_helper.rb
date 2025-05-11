module ApplicationHelper
  include ColorMapping
    def default_meta_tags
      {
        site: "ColorMirror",
        title: "自分の気分を色で表現して、AIとともに向きあう体験をするサービス",
        reverse: true,
        charset: "utf-8",
        description: "人間関係や、気候の変動で上下する気分を色を通して可視化や、AIによる言語化を通して自己と向き合うセルフケアを目的とします",
        keywords: "感情、天気、色、AI, 傾向、分析",
        canonical: request.original_url,
        separator: "|",
        og: {
          site_name: :site,
          title: :title,
          description: :description,
          type: "website",
          url: request.original_url,
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
end
