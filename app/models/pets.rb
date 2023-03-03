require 'httparty'
require 'json'

class PetFinderAPI
  include HTTParty

  API_BASE_URI = 'https://api.petfinder.com/v2'
  API_KEY = 'yf0BpvnxgEIApOIZ2OV71ObWGE8T3nxqebIrZVGmdynJtNO95h'
  API_SECRET = '5rzQEqynWUBgUzB9kWrOXn6pNPqUC9jnfqXxSrSC'
  ACCESS_TOKEN = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ5ZjBCcHZueGdFSUFwT0laMk9WNzFPYldHRThUM254cWViSXJaVkdtZHluSnROTzk1aCIsImp0aSI6ImM1N2FiNWIwN2FkNDMwYTRhMWVhNWQ3Y2NkMWM5ZmUyMmZhZDIxNmQyMDUzYTQwYjQ3ZDc1NzRhMmI3YzBjNDcxZDM3MWJjYjJjYzY0ZWU2IiwiaWF0IjoxNjc3NzUxNzU5LCJuYmYiOjE2Nzc3NTE3NTksImV4cCI6MTY3Nzc1NTM1OSwic3ViIjoiIiwic2NvcGVzIjpbXX0.mB8p22hEX-XNhnKRX5-CE5sE28SgrcXH9IkkDxK1Pt9fOoaUl-_IsOf8PabzGVznNGe6qiFlw06vBBROfiXBoKH_yUSYK2okvetjp1rFLtcsCN6zQxRYagj3BfwM2gAQs_iyRtILhLQA8qzJFeJy3tKKCCUfKLzOelW3cqDIQXoeS2IpEIEUIcJJasB64uQnEK_-YzNeDAGkzFUqAnnH5kMMBGAM6UTis1Q8p2agQjGGD9qAJjnCUICw63qBhB1ceTn6na_jnKiBPu8XP0rlAgcUITdid_G6KjlB-n6_ppmb59tCST-TzM7AkidkqZscJgTHKD1grang4N7xglfoww'

  headers 'Authorization' => "Bearer #{ACCESS_TOKEN}"

  def self.get_animals(type)
    response = get("#{API_BASE_URI}/animals?type=#{type}&limit=100", headers: headers)
    response.parsed_response['animals']
  end
end

class Pet < ActiveRecord::Base
end

animal_types = ['dogs', 'cats', 'rabbits']

animal_types.each do |type|
  animals = PetFinderAPI.get_animals(type)

  animals.each do |animal|
    pet = Pet.new(
      Type: animal['type'],
      name: animal['name'],
      breed: animal['breeds']['primary'],
      size: animal['size'],
      gender: animal['gender'],
      age: animal['age'],
      color: animal['colors']['primary'],
      location: "#{animal['contact']['address']['city']}, #{animal['contact']['address']['state']}",
      photo_url: animal['photos'].first['medium']
    )

    pet.save
  end
end

