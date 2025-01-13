class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.references :self_log, null: false, foreign_key: true # 外部キー列
      t.string :ai_comment, null: false
      t.timestamps
    end
  end
end
