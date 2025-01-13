class CreateWhetherLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :whether_logs do |t|
      t.references :self_log, null: false, foreign_key: true # 外部キー列
      t.datetime :fetched_at
      t.integer :whether_pressure
      t.string :whether_condition
      t.integer :temperature
      t.timestamps
    end
  end
end
