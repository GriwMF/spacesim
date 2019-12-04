class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }, null: false
      t.string :locale, null: false, default: 'en'
      t.string :password_digest

      t.timestamps
    end
  end
end
