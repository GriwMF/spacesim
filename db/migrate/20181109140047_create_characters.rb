class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :position
      t.references :base, polimorphic: true
      t.integer :action_time, null: false, default: 0
      t.integer :hp, null: false, default: 100
      t.integer :hunger, null: false, default: 0
      t.integer :fatigue, null: false, default: 0
      t.integer :skill, null: false, default: 0

      t.timestamps
    end
  end
end
