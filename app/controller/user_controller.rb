require 'bcrypt'

class UserController < Sinatra::Base
  # Route to display all users
  get '/users/all' do
    users = User.all
    users.to_json
  end

  # Route to create a new user
  post '/users/create' do
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
      password_hash = BCrypt::Password.create(data['password'])
      new_user = User.create(
        username: data['username'],
        password_hash: password_hash,
        email: data['email']
      )

      # Save the user to the database
      new_user.save

      # Return the newly created user as JSON
      new_user.to_json
    end
  end

  # Route to authenticate a user
  post '/users/authenticate' do
    # Parse the request body JSON
    data = JSON.parse(request.body.read)

    # Find the user by username
    user = User.find_by(username: data['username'])

    if user && BCrypt::Password.new(user.password_hash) == data['password']
      # Return the authenticated user as JSON
      user.to_json
      session[:user_id] = user.id
    else
      # Return an error if authentication fails
      status 401
      { message: 'Invalid username or password' }.to_json
    end
  end




end
