class CreateFacilitiesSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities_systems do |t|
      t.string :type
      t.integer :durability
      t.integer :max_production
      t.references :bay, foreign_key: true

      t.timestamps
    end
  end
end
