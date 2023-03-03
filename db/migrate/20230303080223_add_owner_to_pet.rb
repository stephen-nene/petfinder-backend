class AddOwnerToPet < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :owner, foreign_key: { to_table: :users }
  end
end
