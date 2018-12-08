class CreateBayStates < ActiveRecord::Migration[5.2]
  def change
    create_table :bay_states do |t|
      t.integer :temp
      t.integer :pressure
      t.integer :integrity
      t.integer :humidity

      t.timestamps
    end
  end
end
