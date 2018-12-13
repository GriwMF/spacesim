class CreateBays < ActiveRecord::Migration[5.2]
  def change
    create_table :bays do |t|
      t.references :ship, foreign_key: true
      t.integer :power, default: 0
      t.integer :max_power, default: 0
      t.integer :oxygen, default: 0
      t.integer :max_oxygen, default: 0
      t.integer :temp, default: 20
      t.integer :integrity, default: 100
      t.integer :humidity, default: 60
      t.string :name

      t.timestamps
    end
  end
end
