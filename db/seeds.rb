require 'rest-client'
require 'json'

puts " "
puts "starting to seed data to the database"
puts " "
Pet.destroy_all

api_key = 'yf0BpvnxgEIApOIZ2OV71ObWGE8T3nxqebIrZVGmdynJtNO95h'
api_secret = '5rzQEqynWUBgUzB9kWrOXn6pNPqUC9jnfqXxSrSC'
token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6IjMzNzZhMTViNzIyZWNhYWJiOTRlZTU0YTdiNWU2NzZmNDVkYTIwYzk3MWNiYWQ4ODNhYmJhM2FhZDI3ZTc2OWFjNTUzMzY0ZjVmNDJmNjVlIiwiaWF0IjoxNjc4MTczMDA0LCJuYmYiOjE2NzgxNzMwMDQsImV4cCI6MTY3ODE3NjYwNCwic3ViIjoiIiwic2NvcGVzIjpbXX0.Vzo3hYUvMSYGZQokvAivBPRjvbE4_7ibTMqqQgokutANw0HW0Q_jZX6iCBfuZXND2-fpTXQiGmdQ5iaxfp326ORd9GOLjJsn8uvBZJpkgrcvFYPlrp6iusNM55kDeav5vXgh0F9gk1ktLFOEul-KYxlS-sXOX5TpkdooJPmGmer9BbRvnW6fgpAsFH6IaTuVYkaVhPx2vk95OlE-i8wPhvcSbk7B2jAXdX_DPCVM6D2-hNmCrtK8NmATGXoUF9qXb1K6j3w3Y8v5T9ej6BBDY0l3Gx6782qCONI2sEuTkgH-DtWmtnDef5Cm2jyQ9F10O_xcwEr4jWdV9yXUePgZiQ"

puts "fetching data ............. "
# Fetch 5 pets for each animal type
animal_types = ['cat', 'dog', 'bird', 'rabbit']
animal_types.each do |animal_type|
  response = RestClient.get 'https://api.petfinder.com/v2/animals', {
    'Authorization' => "Bearer #{token}",
    params: {
      type: animal_type,
      limit: 5
    }
  }
  created_at = Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now)
  updated_at = Faker::Time.between(from: created_at, to: DateTime.now)

  # Save each pet to the database
  pets = JSON.parse(response)['animals']
  pets.each do |pet|
    age = rand(3..10)
    Pet.create(
      name: pet['name'],
      animal_type: pet['type'],
      breed: pet['breeds']['primary'],
      age: age,
      gender: pet['gender'],
      description: pet['description'],
      url: pet['url'],
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

pet_ids.sample(5).each do |pet_id|
  owner_id = User.pluck(:id).sample
  Pet.find(pet_id).update(owner_id: owner_id)
end

puts "done seeding....\n"
puts " "
puts "****************happy-hacking****************"
