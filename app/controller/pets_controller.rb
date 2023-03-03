class PetsController < Sinatra::Base
  # include ActionController::Parameters

  get '/' do
    'Welcome to Petfinder!'
  end
  post '/pets/create' do
    pet_params = params[:pet].slice(:name, :animal_type, :breed, :age, :gender, :description)
    pet = Pet.new(pet_params)

    if pet.save
      status 201
      { message: "Pet with ID #{pet.id} has been created." }.to_json
    else
      status 422
      error_messages = pet.errors.full_messages.join(', ')
      { error: error_messages }.to_json
    end

    pet_params.to_json
  end




  get '/pets' do
    # logic to retrieve and display pets
    pets = Pet.all
    if pets
      content_type :json
      pets.map { |pet| { pet: pet } }.to_json
    else
      halt 404
    end
  end

  get '/pets/:id' do
    # logic to retrieve and display a specific pet
    pet = Pet.find(params[:id])
    if pet
      content_type :json
      { pet: pet }.to_json
    else
      halt 404
    end
  end


  patch '/pets/:id' do
    # logic to update a specific pet
    pet = Pet.find(params[:id])
    if pet
      pet_params = params.slice(:name, :animal_type, :breed, :age, :gender, :description)
      if pet.update(pet_params)
        { pet: pet }.to_json
      else
        status 422
        error_messages = pet.errors.full_messages.join(', ')
        { error: error_messages }.to_json
      end
    else
      halt 404
    end
  end

  delete '/pets/:id' do
    # logic to delete a specific pet
    pet = Pet.find(params[:id])
    if pet
      pet.destroy
      { message: "Pet deleted" }.to_json
    else
      halt 404
    end
  end

    get '/test' do
      "App is working fine"
    end

end
