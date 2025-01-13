class CreateAnalysisResults < ActiveRecord::Migration[8.0]
  def change
    create_table :analysis_results do |t|
      t.references :response, null: false, foreign_key: true # 外部キー列
      t.string :analysis_value
      t.string :analysis_type
      t.timestamps
    end
  end
end
