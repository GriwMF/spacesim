class CreateFacilitiesSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities_systems do |t|
      t.references :ship, foreign_key: true
      t.string :type
      t.integer :power, default: 0
      t.integer :priority, default: 0
      t.integer :max_power, default: 0
      t.integer :oxygen, default: 0
      t.integer :max_oxygen, default: 0
      t.integer :temp, default: 20
      t.decimal :integrity, default: 100
      t.integer :humidity, default: 60
      t.integer :max_production
      t.integer :consumption
      t.json :params

      t.timestamps
    end

    add_index :facilities_systems, %i[priority ship_id type]
  end
end
