class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.integer :hp
      t.string :name
      t.belongs_to :solar_system, foreign_key: true
      t.belongs_to :celestial_object, foreign_key: true
      t.byte :progress

      t.timestamps
    end
  end
end
