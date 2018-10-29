class CreateSolarSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :solar_systems do |t|
      t.string :name
      t.integer :x
      t.integer :y
      t.integer :z

      t.timestamps
    end
  end
end
