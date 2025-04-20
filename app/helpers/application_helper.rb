module ApplicationHelper
  include ColorMapping

  def rgb_to_hex(rgb_string)
    # 半角スペースと数字のみを対象にし、float→四捨五入して処理
    rgb_values = rgb_string.scan(/[\d.]+/).map(&:to_f).map(&:round).first(3)
    return nil unless rgb_values.length == 3

    format("#%02x%02x%02x", *rgb_values)
  end
end
