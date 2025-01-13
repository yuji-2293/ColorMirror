class CreateSelfLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :self_logs do |t|
      t.references :color, null: false, foreign_key: true # 外部キー列
      t.references :user, null: false, foreign_key: true # 外部キー列
      t.timestamps
    end
  end
end
