class CreateCelestialObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :celestial_objects do |t|
      t.string :name
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z

      t.timestamps
    end
  end
end
