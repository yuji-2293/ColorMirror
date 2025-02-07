class RemoveFromResponses < ActiveRecord::Migration[8.0]
  def change
    remove_column :responses, :ai_comment, :string
  end
end
