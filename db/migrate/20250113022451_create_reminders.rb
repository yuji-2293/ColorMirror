class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true # 外部キー列
      t.string :title
      t.string :description, null: false
      t.datetime :remind_at
      t.string :status
      t.timestamps
    end
  end
end
