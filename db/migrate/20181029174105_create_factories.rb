class CreateFactories < ActiveRecord::Migration[5.2]
  def change
    create_table :factories do |t|
      t.string :name
      t.integer :type
      t.integer :time
      t.integer :altitude
      t.references :celestial_object, foreign_key: true
      t.integer :progress, default: 0, limit: 1, null: false

      t.timestamps
    end
  end
end
