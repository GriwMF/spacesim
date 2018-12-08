class CreateBays < ActiveRecord::Migration[5.2]
  def change
    create_table :bays do |t|
      t.references :ship, foreign_key: true

      t.timestamps
    end
  end
end
