class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.string :name
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.decimal :integrity, default: 100
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :bonus_speed, default: 0, null: false
      t.integer :speed
      t.integer :storage
      t.boolean :fly
      t.boolean :alarm

      t.timestamps
    end
  end
end
