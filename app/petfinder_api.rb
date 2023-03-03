# require 'json'
# require 'net/http'
# require 'uri'
# require_relative "./models/pets"

# Set up database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/all-pets.sqlite3'
)

# Replace YOUR_API_KEY and YOUR_API_SECRET with your actual credentials
api_key = 'yf0BpvnxgEIApOIZ2OV71ObWGE8T3nxqebIrZVGmdynJtNO95h'
api_secret = '5rzQEqynWUBgUzB9kWrOXn6pNPqUC9jnfqXxSrSC'

# Set up HTTP client
uri = URI.parse('https://api.petfinder.com/v2/animals')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# Set up authorization header with API key and secret
headers = {
  'Authorization' => "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6ImM1N2FiNWIwN2FkNDMwYTRhMWVhNWQ3Y2NkMWM5ZmUyMmZhZDIxNmQyMDUzYTQwYjQ3ZDc1NzRhMmI3YzBjNDcxZDM3MWJjYjJjYzY0ZWU2IiwiaWF0IjoxNjc3NzUxNzU5LCJuYmYiOjE2Nzc3NTE3NTksImV4cCI6MTY3Nzc1NTM1OSwic3ViIjoiIiwic2NvcGVzIjpbXX0.mB8p22hEX-XNhnKRX5-CE5sE28SgrcXH9IkkDxK1Pt9fOoaUl-_IsOf8PabzGVznNGe6qiFlw06vBBROfiXBoKH_yUSYK2okvetjp1rFLtcsCN6zQxRYagj3BfwM2gAQs_iyRtILhLQA8qzJFeJy3tKKCCUfKLzOelW3cqDIQXoeS2IpEIEUIcJJasB64uQnEK_-YzNeDAGkzFUqAnnH5kMMBGAM6UTis1Q8p2agQjGGD9qAJjnCUICw63qBhB1ceTn6na_jnKiBPu8XP0rlAgcUITdid_G6KjlB-n6_ppmb59tCST-TzM7AkidkqZscJgTHKD1grang4N7xglfoww",
  'Content-Type' => 'application/json',
  'Accept' => 'application/json'
}

# Create an array of pet types to fetch
pet_types = ['dog', 'cat', 'fish']

# Fetch pets for each pet type
pet_types.each do |pet_type|
  # Set up query parameters for pet type and number of pets to fetch
  params = {
    'type' => pet_type,
    'limit' => 100
  }

  # Fetch pets from API
  uri.query = URI.encode_www_form(params)
  response = http.get(uri.request_uri, headers)
  pets = JSON.parse(response.body)

  # Iterate through each fetched pet and save to database
  pets['animals'].each do |pet_data|
    # Extract relevant data from pet data
    pet = Pet.new(
      Type: pet_data['type'],
      name: pet_data['name'],
      breed: pet_data['breeds']['primary'],
      size: pet_data['size'],
      gender: pet_data['gender'],
      age: pet_data['age'],
      color: pet_data['colors']['primary'],
      photo_url: pet_data['photos'][0]['full']
    )

    # Save pet data to database
    pet.save
  end
end
