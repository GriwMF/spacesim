class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :position
      t.references :base, polymorphic: true
      t.integer :action, limit: 1

      t.timestamps
    end
  end
end
