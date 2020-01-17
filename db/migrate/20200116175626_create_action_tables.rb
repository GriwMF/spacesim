class CreateActionTables < ActiveRecord::Migration[5.2]
  def change
    create_table :action_tables do |t|
      t.string :action_type
      t.references :ship, foreign_key: true
      t.json :params
      t.integer :priority

      t.timestamps
    end
  end
end
