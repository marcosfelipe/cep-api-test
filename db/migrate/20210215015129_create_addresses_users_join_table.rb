class CreateAddressesUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :addresses, :users
  end
end
