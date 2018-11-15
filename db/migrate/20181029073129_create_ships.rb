class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.integer :hp
      t.string :name
      t.belongs_to :solar_system, foreign_key: true
      t.belongs_to :celestial_object, foreign_key: true
      t.belongs_to :production, foreign_key: true
      t.belongs_to :target, polimorphic: true
      t.integer :action, limit: 1
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :bonus_speed, default: 0, null: false
      t.integer :speed
      t.integer :storage
      t.integer :energy
      t.integer :o2
      t.boolean :fly

      t.timestamps
    end
  end
end
