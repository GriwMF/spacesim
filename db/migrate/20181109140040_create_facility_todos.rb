class CreateFacilityTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :facility_todos do |t|
      t.references :facilities_system, foreign_key: true
      t.integer :role, limit: 1
      t.integer :required_personell_count
      # todo: add priority?

      t.timestamps
    end
  end
end
