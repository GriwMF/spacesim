class CreateCelestialObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :celestial_objects do |t|
      t.references :parent_object, index: true, foreign_key: { to_table: :celestial_objects }
      t.string :name
      t.integer :altitude

      t.timestamps
    end
  end
end
