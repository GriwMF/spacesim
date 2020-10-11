class CreateWorldData < ActiveRecord::Migration[5.2]
  def change
    create_table :world_data do |t|
      t.string :key
      t.integer :value

      t.timestamps
    end
  end
end
