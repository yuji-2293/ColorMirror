class RemoveForeignKeyFromSelfLogs < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :colors, :users # users の外部キー制約を削除
  end
end
