class AddlineAlertTousers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :line_alert, :integer
  end
end
