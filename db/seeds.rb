require 'bcrypt'


User.destroy_all

# Add a single user to the database
user = User.create!(
  username: Faker::Name.name,
  email: Faker::Internet.email,
  password_hash: BCrypt::Password.create('password'),
  created_at: DateTime.now,
  updated_at: DateTime.now
)


Pet.destroy_all




10.times do |i|
  animal_types = ['Dog', 'Cat', 'Horse']

  animal_type = animal_types.sample
  name = Faker::Creature.const_get(animal_type).name
  breed = Faker::Creature.const_get(animal_type).breed

  age = rand(1..15)
  gender = ["Male", "Female"].sample
  description = Faker::Lorem.paragraph(sentence_count: 2)
  created_at = Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now)
  updated_at = Faker::Time.between(from: created_at, to: DateTime.now)

  pet = Pet.create!(
    name: name,
    animal_type: animal_type,
    breed: breed,
    age: age,
    gender: gender,
    description: description,
    created_at: created_at,
    updated_at: updated_at
  )
end
 # Add pets to user with id 1
10.times do |i|
  animal_types = ['Dog', 'Cat', 'Horse']

  animal_type = animal_types.sample
  name = Faker::Creature.const_get(animal_type).name
  breed = Faker::Creature.const_get(animal_type).breed

  age = rand(1..15)
  gender = ["Male", "Female"].sample
  description = Faker::Lorem.paragraph(sentence_count: 2)
  created_at = Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now)
  updated_at = Faker::Time.between(from: created_at, to: DateTime.now)


  pet = Pet.create!(
    name: name,
    animal_type: animal_type,
    breed: breed,
    age: age,
    gender: gender,
    description: description,
    created_at: created_at,
    updated_at: updated_at,
    owner_id: user.id
  )

end
