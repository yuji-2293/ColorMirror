class RemoveNotNullConstraintFromResponses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :responses, :ai_comment, true
  end
end
