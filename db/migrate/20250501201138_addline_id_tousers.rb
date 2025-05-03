class AddlineIdTousers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :line_id, :string
  end
end
