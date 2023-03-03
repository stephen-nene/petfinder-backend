class PetsController < Sinatra::Base

  get '/' do
    'Welcome to Petfinder!'
  end

  post '/pets/create' do
    # Get the parameters from the request
    name = params[:name]
    animal_type = params[:animal_type]
    breed = params[:breed]
    age = params[:age]
    gender = params[:gender]
    description = params[:description]

    # Create a new Pet object with the given parameters
    pet = Pet.create(name: name, animal_type: animal_type, breed: breed, age: age, gender: gender, description: description)

    # If the pet is successfully saved, return a success message with the pet's ID
    if pet.save
      { message: "Pet with ID #{pet.id} has been created." }.to_json
    else
      # If there was an error saving the pet, return an error message
      status 500
      { error: "Could not create pet." }.to_json
    end
  end


  get '/pets' do
    # logic to retrieve and display pets
  end

  get '/pets/:id' do
    # logic to retrieve and display a specific pet
  end


  patch '/pets/:id' do
    # logic to update a specific pet
  end

  delete '/pets/:id' do
    # logic to delete a specific pet
  end

    get '/test' do
      "App is working fine"
    end

end
