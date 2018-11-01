class CreateFactories < ActiveRecord::Migration[5.2]
  def change
    create_table :factories do |t|
      t.string :name
      t.integer :speed, limit: 1
      t.integer :altitude
      t.integer :progress, default: 0, limit: 1, null: false
      t.integer :storage
      t.references :celestial_object, foreign_key: true

      t.timestamps
    end
  end
end
