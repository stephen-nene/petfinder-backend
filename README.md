# petfinder-backend
Petfinder-backend is a Sinatra-based backend application that provides endpoints for the Petfinder web application. It is responsible for handling user authentication, retrieving and managing pet data from the Petfinder API, and managing user reviews for individual pets.
<!-- - contains endpoint for my sinatra backend
- The application uses the `sinatra/cross_origin `gem to enable Cross-Origin Resource Sharing (`CORS`) support. It also uses the `bcrypt` gem for password hashing. -->


## Technologies
- Petfinder-backend uses the following technologies:
1. Ruby 2.7.4
2. Sinatra 2.1.0
3. sinatra/cross_origin gem for enabling Cross-Origin Resource Sharing (CORS) support
4. bcrypt gem for password hashing

## endpoints
- PetsController handles routes related to pets. The routes include:

1. `get '/' `- a route to display a welcome message.
2. `get '/mypet'` - a route to retrieve pets by the owner's ID.
3. `post '/pets/create'` - a route to create a new pet record.
4. `get '/pets'` - a route to retrieve all pets or pets by the owner's ID.
5. `get '/pets/:id'` - a route to retrieve a specific pet by ID.
6. `put "/pets/update/:id"` - a route to update a specific pet by ID.
7. `delete '/pets/:id_or_name_or_breed'` - a route to delete a pet record by ID, name, or breed.
8. `get '/test'` - a route to test if the app is working.
- UserController handles routes related to users. The routes include:

1. `get '/users/:id'` - a route to retrieve a specific user by ID.
2. `get '/users' `- a route to retrieve all users.
3. `post '/users/create'` - a route to create a new user record.


## Project Setup

- clone this repository by copying the code below to your terminal

```bash
https://github.com/stephen-nene/Product-Review_Code-Challenge
```
- cd into the directory with the cloned files

```bash
cd Product-Review_Code-Challenge
```

- run bundle install to get all the gem dependencies installed
```
bundle install
bundle update
```
- To run the magazine-domain use rake tasks

```bash
bundle exec rake run
```

## Owner

1. [Steve Nene](https://github.com/stephen-nene)

   ### Message from contributor
- I appreciate your interest in our project, and we hope that you find it helpful and informative. If you have any questions or feedback, please feel free to reach out to us. Thank you for choosing our Product Review project!


## License

- **NeneCorp** <span>&copy;</span>

