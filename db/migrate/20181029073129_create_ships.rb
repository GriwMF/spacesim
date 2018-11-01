class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.integer :hp
      t.string :name
      t.belongs_to :solar_system, foreign_key: true
      t.belongs_to :celestial_object, foreign_key: true
      t.belongs_to :target, foreign_key: { to_table: :celestial_objects }
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :speed
      t.integer :progress, limit: 1
      t.integer :storage

      t.timestamps
    end
  end
end
