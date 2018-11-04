class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.integer :hp
      t.string :name
      t.belongs_to :solar_system, foreign_key: true
      t.belongs_to :celestial_object, foreign_key: true
      t.belongs_to :target, foreign_key: { to_table: :productions }
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :speed
      t.integer :storage

      t.timestamps
    end
  end
end
