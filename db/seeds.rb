require 'rest-client'
require 'json'

puts " "
puts "starting to seed data to the database"
puts " "
Pet.destroy_all

api_key = 'yf0BpvnxgEIApOIZ2OV71ObWGE8T3nxqebIrZVGmdynJtNO95h'
api_secret = '5rzQEqynWUBgUzB9kWrOXn6pNPqUC9jnfqXxSrSC'
token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6IjE2ZWI4YmYwODgxODc5NWExZGFhOGI5MzM3ZTBjNzI5MzRiOGNhMjFiZWZmZTNhMzAwZmZjMjRmNWFmNDM5ZDY0MDE5YzllOGViZTgwMzMzIiwiaWF0IjoxNjc4MTc4Mzc5LCJuYmYiOjE2NzgxNzgzNzksImV4cCI6MTY3ODE4MTk3OSwic3ViIjoiIiwic2NvcGVzIjpbXX0.WvFXfwgyfxgTKRuKUjfZWBfJVE-MKDjDxucV-mC-6d89po5YSveAZziKpJwkX3EJPlISytIPXOHNW_Ka3SqYwSzxAFVIINnAeJeFH_eoVWAQb71HAjjp_TeG-kAtSGGUANrWmTTifz7lreNUuj-U9qNnxXJXSqLTjEOU5UAzpOMLXMe5KrpTQO7gqMcxtzJp13GypQXPj89y4ymJR4cW6xLpHVlxljogOIY1D8pyLcbosUDE0Hxa340ifBcfr3b4Ds4JqiMKV5ZenjflJ6FhN6_MaV1TDyB11eup0EuI77lN04FCfQ1EYz3-RHeP72wD8DFrMtJFWbtlQLuJJITDXA"

puts "fetching data ............. "
# Fetch 5 pets for each animal type
animal_types = ['cat', 'dog', 'bird', 'rabbit']
animal_types.each do |animal_type|
  response = RestClient.get 'https://api.petfinder.com/v2/animals', {
    'Authorization' => "Bearer #{token}",
    params: {
      type: animal_type,
      limit: 10
    }
  }
  created_at = Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now)
  updated_at = Faker::Time.between(from: created_at, to: DateTime.now)

  # Save each pet to the database
  pets = JSON.parse(response)['animals']
  pets.each do |pet|
    if pet['photos'][0].present?
      url = pet['photos'][0]['medium']
      # puts pet['photos'][0]['medium']
    end
    age = rand(3..10)
    Pet.create(
      name: pet['name'],
      animal_type: pet['type'],
      breed: pet['breeds']['primary'],
      age: age,
      gender: pet['gender'],
      description: pet['description'],
      url: url,
      created_at: created_at,
      updated_at: updated_at
    )
  end
end

puts " "
puts "done Fetching"
puts " "
User.destroy_all

# add a user to the database
def create_user(wangapi)
  wangapi.times do
    User.create!(
      username: Faker::Name.name,
      email: Faker::Internet.email,
      password_hash: BCrypt::Password.create('password'),
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
  end
end
create_user(3)


# puts ".....assigning a pet to a user....."
puts " "
pet_ids = Pet.pluck(:id)

pet_ids.sample(10).each do |pet_id|
  owner_id = User.pluck(:id).sample
  Pet.find(pet_id).update(owner_id: owner_id)
end

puts "done seeding....\n"
puts " "
puts "****************happy-hacking****************"
