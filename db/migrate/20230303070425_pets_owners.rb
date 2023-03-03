class PetsOwners < ActiveRecord::Migration[7.0]
  def change
        create_table :pet_owners do |t| # changed table name to plural
          t.references :user, null: false, foreign_key: true # added foreign key to users table
          t.references :pet, null: false, foreign_key: true # added foreign key to pets table
          t.string :api_id # added API ID for linking with pets table
          t.timestamps
        end
  end
end
