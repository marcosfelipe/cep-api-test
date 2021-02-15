class AddressesService
  def initialize(data, user)
    @address = data
    @user = user
  end


  def save
    address = Address.find_by_zipcode(@address['zipcode'])
    unless address
      address = Address.create(street: @address[:street],
                     address: @address[:address],
                     neighborhood: @address[:neighborhood],
                     city: @address[:city],
                     state: @address[:state],
                     zipcode: @address[:zipcode],
                     result: @address)
    end
    @user.addresses << address
  end

end