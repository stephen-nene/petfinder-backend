# Import the gem
require 'sinatra/cross_origin'

class PetsController < Sinatra::Base
  # Register the gem
  # register Sinatra::CrossOrigin

  # # include ActionController::Parameters
  # configure do
  #   enable :cross_origin
  #   set :allow_origin, :any
  #   set :allow_methods, [:get, :post, :put, :delete, :options]
  #   set :allow_headers, ["*", "Content-Type", "Accept", "Authorization"]
  # end

  # Route to display a welcome message
  get '/' do
    'Welcome to Petfinder!'
  end

 # Route to create a new pet
 post '/pets/create' do
  data = JSON.parse(request.body.read)
  puts "Received request to create pet: #{data.inspect}"

  begin
    # approach 2 (hash of a column)
    pet = Pet.create(data)
    { message: "Pet with ID #{pet.id} has been created." }.to_json

  rescue StandardError => e
    status 400
    { error: e.message }.to_json
  end
end

  # Route to display all pets
  get '/pets' do
    pets = Pet.all
    if pets
      content_type :json
      pets.map { |pet| { pet: pet } }.to_json
    else
      status 404
      { error: "No pets found" }.to_json
    end
  end

  # Route to display a specific pet by ID
  get '/pets/:id' do
    pet = Pet.find(params[:id])
    if pet
      content_type :json
      { pet: pet }.to_json
    else
      halt 404
    end
  end

# Route to update a specific pet by ID
put "/pets/update/:id" do
  begin
    pet_id = params["id"].to_i
    pet = Pet.find(pet_id)
    pet_params = JSON.parse(request.body.read)
    pet_params.delete("id") # Remove "id" key from params since it is not needed for updating
    if pet.update(pet_params)
      { message: "Pet updated successfully" }.to_json
    else
      status 422
      error_messages = pet.errors.full_messages.join(', ')
      { error: error_messages }.to_json
    end
  rescue ActiveRecord::RecordNotFound
    status 404
    { error: "Pet not found" }.to_json
  rescue => e
    status 400
    { error: e.message }.to_json
  end
end


delete '/pets/:id_or_name_or_breed' do
  pet = Pet.find_by(id: params[:id_or_name_or_breed]) ||
        Pet.find_by(name: params[:id_or_name_or_breed]) ||
        Pet.find_by(breed: params[:id_or_name_or_breed])

  if pet
    pet.destroy
    { message: "Pet deleted" }.to_json
  else
    halt 404
  end
end

  # Route to test if the app is working
  get '/test' do
    "App is working fine"
  end
end
