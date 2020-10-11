class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.references :material, foreign_key: true
      t.references :factory, foreign_key: true
      t.boolean :is_output, default: false, null: false
      t.integer :amount

      t.timestamps
    end
  end
end
