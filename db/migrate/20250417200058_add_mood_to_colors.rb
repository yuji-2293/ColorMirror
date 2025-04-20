class AddMoodToColors < ActiveRecord::Migration[8.0]
  def change
    add_column :colors, :mood, :string
  end
end
