class AddControlToBays < ActiveRecord::Migration[5.2]
  def change
    add_column :bays, :control, :boolean, index: true
  end
end
