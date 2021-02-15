FactoryGirl.define do
  street = Faker::Address.street_name
  neighborhood = Faker::Address.city
  city = Faker::Address.city
  state = Faker::Address.state
  zipcode = Faker::Number.number(digits: 8)
  address = "#{street},#{neighborhood} - #{city}/#{state} #{zipcode}"

  factory :address do
    street street
    address address
    neighborhood neighborhood
    city city
    state state
    zipcode zipcode
    result "{street: #{street}', address: #{address}, neighborhood: #{neighborhood}, city: #{city}, state: #{state}, zipcode: #{zipcode}}".to_json
  end
end