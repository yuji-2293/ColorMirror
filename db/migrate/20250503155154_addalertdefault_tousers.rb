class AddalertdefaultTousers < ActiveRecord::Migration[8.0]
  def up
    execute("UPDATE users SET line_alert = 0 WHERE line_alert IS NULL")
    change_column :users, :line_alert, :integer, default: 0, null: false
  end

  def down
    change_column :users, :line_alert, :integer, default: nil, null: true
  end
end
