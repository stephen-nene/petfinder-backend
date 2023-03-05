class AddUrlColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :url, :string
  end
end
