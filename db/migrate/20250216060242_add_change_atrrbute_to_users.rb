class AddChangeAtrrbuteToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :prefecture, 'integer USING NULLIF(prefecture, \'\')::integer'
  end
end
