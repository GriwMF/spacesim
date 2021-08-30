class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :object, polymorphic: true
      t.references :ship, foreign_key: true
      t.text :action
      t.boolean :notify
      t.json :params

      t.timestamps
    end
  end
end
