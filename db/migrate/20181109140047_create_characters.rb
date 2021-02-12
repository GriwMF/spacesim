class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.references :facility_todos, foreign_key: true
      t.string :name
      t.integer :role, limit: 1
      t.references :base, polymorphic: true
      t.references :location, polymorphic: true
      t.integer :hp, null: false, default: 100
      t.integer :hunger, null: false, default: 0
      t.integer :fatigue, null: false, default: 0
      t.integer :skill, null: false, default: 0
      t.integer :skip, null: false, default: 0
      t.integer :skip_reason

      t.timestamps
    end
  end
end
