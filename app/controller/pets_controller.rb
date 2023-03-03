class PetsController < Sinatra::Base
  # include ActionController::Parameters

  # Route to display a welcome message
  get '/' do
    'Welcome to Petfinder!'
  end

  private

# def pet_params
#   params.require(:pet).permit(:name, :animal_type, :breed, :age, :gender, :description)
# end

  # Route to create a new pet
  post '/pets/create' do
    begin
      pet = Pet.new(name: params[:name], animal_type: params[:animal_type], breed: params[:breed], age: params[:age], gender: params[:gender], description: params[:description])

      if pet.save
        { message: "Pet with ID #{pet.id} has been created." }.to_json
      else
        status 400
        { error: pet.errors.full_messages.join(', ') }.to_json
      end
    rescue => e
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
  patch '/pets/:id' do
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

  # Route to delete a specific pet by ID
  delete '/pets/:id' do
    pet = Pet.find(params[:id])
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
