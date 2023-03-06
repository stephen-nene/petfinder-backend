require 'bcrypt'

class UserController < Sinatra::Base
  before do
    set_cors_headers
  end

  private

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'

    if request.request_method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
      halt 200
    end
  end

  # Route to get a specific user
get '/users/:id' do
  user = User.find(params[:id])
  if user
    content_type :json
    { user: user }.to_json
  else
    status 404
    { error: "User not found" }.to_json
  end
end

  # Route to display all users
  get '/users' do
    users = User.all
    if users
      content_type :json
      users.map { |user| { user: user } }.to_json
    else
      status 404
      { error: "No pets found" }.to_json
    end
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
    # Set the session user_id to the authenticated user's id
    session[:user_id] = user.id

    puts session[:user_id]

    # Return the authenticated user as JSON
    user.to_json
  else
    # Return an error if authentication fails
    status 401
    { message: 'Invalid username or password' }.to_json
  end
end





end
