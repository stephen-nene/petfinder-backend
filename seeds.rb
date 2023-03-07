require 'rest-client'
require 'json'
require "faker"

token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6IjE2ZWI4YmYwODgxODc5NWExZGFhOGI5MzM3ZTBjNzI5MzRiOGNhMjFiZWZmZTNhMzAwZmZjMjRmNWFmNDM5ZDY0MDE5YzllOGViZTgwMzMzIiwiaWF0IjoxNjc4MTc4Mzc5LCJuYmYiOjE2NzgxNzgzNzksImV4cCI6MTY3ODE4MTk3OSwic3ViIjoiIiwic2NvcGVzIjpbXX0.WvFXfwgyfxgTKRuKUjfZWBfJVE-MKDjDxucV-mC-6d89po5YSveAZziKpJwkX3EJPlISytIPXOHNW_Ka3SqYwSzxAFVIINnAeJeFH_eoVWAQb71HAjjp_TeG-kAtSGGUANrWmTTifz7lreNUuj-U9qNnxXJXSqLTjEOU5UAzpOMLXMe5KrpTQO7gqMcxtzJp13GypQXPj89y4ymJR4cW6xLpHVlxljogOIY1D8pyLcbosUDE0Hxa340ifBcfr3b4Ds4JqiMKV5ZenjflJ6FhN6_MaV1TDyB11eup0EuI77lN04FCfQ1EYz3-RHeP72wD8DFrMtJFWbtlQLuJJITDXA"

puts "fetching data ............. "
# Fetch 5 pets for each animal type
animal_types = ['dog']
animal_types.each do |animal_type|
  response = RestClient.get 'https://api.petfinder.com/v2/animals', {
    'Authorization' => "Bearer #{token}",
    params: {
      type: animal_type,
      limit: 30
    }
  }


  # Save each pet to the database
  pets = JSON.parse(response)['animals']
  pets.each do |pet|
    age = rand(3..10)
    puts "Name: #{pet["name"]}"
    puts "id: #{pet[""]}"
    # puts pet["photos"][0]["medium"]
  end
end
