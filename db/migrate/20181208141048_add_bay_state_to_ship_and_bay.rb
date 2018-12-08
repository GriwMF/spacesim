class AddBayStateToShipAndBay < ActiveRecord::Migration[5.2]
  def change
    add_reference :ships, :bay_state, foreign_key: true
    add_reference :bays, :bay_state, foreign_key: true
  end
end
