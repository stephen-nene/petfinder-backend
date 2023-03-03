class CreatePet < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :animal_type
      t.string :breed
      t.string :age
      t.string :gender
      t.string :description
      t.timestamps
    end
  end
end
