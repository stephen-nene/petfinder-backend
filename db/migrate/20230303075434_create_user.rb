class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false, index: { unique: true, name: 'uk_email' }
      t.string :password_hash, null: false

      t.timestamps
    end
  end
end
