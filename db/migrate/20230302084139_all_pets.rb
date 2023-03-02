class AllPets < ActiveRecord::Migration[7.0]
  def change
    create_table :allPets do |t|
      t.string :Type
      t.string :name
      t.string :breed
      t.string :size
      t.string :gender
      t.string :age
      t.string :color
      t.string :location
      t.string :photo_url
    end
  end
end
