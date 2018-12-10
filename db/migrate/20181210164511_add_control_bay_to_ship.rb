class AddControlBayToShip < ActiveRecord::Migration[5.2]
  def change
    add_reference :ships, :control_bay, foreign_key: { to_table: :bays }
  end
end
