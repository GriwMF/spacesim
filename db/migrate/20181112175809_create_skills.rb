class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.references :character, foreign_key: true
      t.integer :skill, null: false
      t.integer :value, null: false, default: 0

      t.timestamps
    end

    add_index :skills, [:skill, :character_id], unique: true
  end
end
