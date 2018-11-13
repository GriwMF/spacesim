class CreateBays < ActiveRecord::Migration[5.2]
  def change
    create_table :bays do |t|
      t.integer :temp
      t.integer :pressure
      t.integer :integrity
      t.integer :humidity
      t.references :ship, foreign_key: true

      t.timestamps
    end
  end
end
