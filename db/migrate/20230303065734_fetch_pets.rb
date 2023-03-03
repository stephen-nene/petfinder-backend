class FetchPets < ActiveRecord::Migration[7.0]
  def change
        create_table :main_pets do |t|
          t.string :name
          t.string :animal_type
          t.string :breed
          t.string :age
          t.string :size
          t.string :gender
          t.string :description
          t.string :photo_url
          t.string :api_id, null: false, index: { unique: true, name: 'idx_api_id' }
          t.timestamps
    end
  end
end
