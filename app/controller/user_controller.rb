class UserController < Sinatra::Base
  # Route to display a welcome message
  get '/users' do
    'Welcome to Petfinder user !'
  end

  # Route to create a new user
  post '/users' do
    # Parse the request body JSON
    data = JSON.parse(request.body.read)

    # Check if the user already exists in the database
    user = User.find_by(username: data['username'])

    if user
      # Return an error if the user already exists
      status 400
      { message: 'User already exists' }.to_json
    else
      # Create a new user with the provided data
      new_user = User.create(
        username: data['username'],
        email: data['email']
      )

      # Set the password using the `password=` method to create a hash
      new_user.password = data['password']

      # Save the user to the database
      new_user.save

      # Return the newly created user as JSON
      new_user.to_json
    end
  end

  # Route to handle user login
  post '/login' do
    # Parse the request body JSON
    data = JSON.parse(request.body.read)

    # Authenticate the user
    user = User.authenticate(data['username'], data['password'])

    if user
      # Return the authenticated user as JSON
      user.to_json
    else
      # Return an error if authentication fails
      status 401
      { message: 'Invalid username or password' }.to_json
    end
  end
end
