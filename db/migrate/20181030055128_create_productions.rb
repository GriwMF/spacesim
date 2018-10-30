class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.references :material, foreign_key: true
      t.references :factory, foreign_key: true
      t.integer :amount
      t.integer :type

      t.timestamps
    end
  end
end
