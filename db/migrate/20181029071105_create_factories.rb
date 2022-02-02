class CreateFactories < ActiveRecord::Migration[5.2]
  def change
    create_table :factories do |t|
      t.string :name
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.integer :speed, limit: 1
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :storage

      t.timestamps
    end
  end
end
