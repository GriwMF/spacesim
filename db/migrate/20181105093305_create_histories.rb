class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :object, polymorphic: true
      t.text :action
      t.json :params

      t.timestamps
    end
  end
end
