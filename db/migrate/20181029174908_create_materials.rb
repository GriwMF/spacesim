class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :weigth

      t.timestamps
    end
  end
end
