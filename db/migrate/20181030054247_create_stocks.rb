class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :material, foreign_key: true
      t.references :object, polymorphic: true
      t.integer :amount

      t.timestamps
    end
  end
end
