# db/seeds.rb

10.times do |i|
  name = Faker::Creature::Animal.name
  animal_type = Faker::Creature::Animal.class_name
  breed = Faker::Creature::Dog.breed
  age = rand(1..15)
  gender = ["Male", "Female"].sample
  description = Faker::Lorem.paragraph(sentence_count: 2)
  created_at = Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now)
  updated_at = Faker::Time.between(from: created_at, to: DateTime.now)

  Pet.create!(
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
