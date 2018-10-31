class CreateFactories < ActiveRecord::Migration[5.2]
  def change
    create_table :factories do |t|
      t.string :name
      t.integer :step_progress, limit: 1
      t.integer :altitude
      t.integer :progress, default: 0, limit: 1, null: false
      t.references :celestial_object, foreign_key: true

      t.timestamps
    end
  end
end
