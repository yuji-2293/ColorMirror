class AddlineTokenTousers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :line_token, :string
  end
end
