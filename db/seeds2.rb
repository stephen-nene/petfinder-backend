require 'rest-client'
require 'json'



# Set up Petfinder API endpoint and access token
endpoint = 'https://api.petfinder.com/v2/animals'
access_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6IjAzNzU1NjA5NTE2YTdiZDk2ZGFmNTljMTRkYzc0NWJjOGY2MGEwZjIzOTE2ZjBkMTIxNDE4MGJkOGQwMDk3Y2E5MjJiYjY3NWNjYmI0MmFhIiwiaWF0IjoxNjc4MDA1NjM4LCJuYmYiOjE2NzgwMDU2MzgsImV4cCI6MTY3ODAwOTIzOCwic3ViIjoiIiwic2NvcGVzIjpbXX0.RXh_N0BB_x-T-XCb30fgBLr7xsRAB1VaFVB-XCKwMGhrvsndSjjQs3UjeyAJUwzcr3RBpjKKM6V1Wkzp70LOKnrNngmH4EwymThfK4giWmHG73QzbLzL_1gQRLmq1EHbhyB0c8IWlbs2frotIwEHPMhBLK7MKN0WfHxZ6T3CgSG9vDkWKphOAfjO6Xpe_0EI6z4ae3Qdk8g_RY3AOSvHLPh7aXmG5rwrUqP2FX4AGC_oQuiV4F5BE-1clExifnh3MM0zJp4hdrR1h_9Cppy_BSGpLc2JweIDTIuJgxJphybwD-R8G5hUxWldZL2a2IBZUeOJF40y6PcYEAl6sgtM6g'
header =  { 'Authorization' => "Bearer #{access_token}" }
# Make request to Petfinder API to fetch pets data
response = RestClient.get(endpoint, header)

if response.code == 200
  pets = response.parsed_response['animals']

  # Loop through each pet and add them to database
  pets.each do |pet|
    animal_type = pet['type']
    name = pet['name']
    breed = pet['breeds']['primary']
    age = pet['age']
    gender = pet['gender']
    description = pet['description']
    created_at = pet['created_at']
    updated_at = pet['updated_at']

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
else
  puts "Error: #{response.code} - #{response.message}"
end


Pet.destroy_all
