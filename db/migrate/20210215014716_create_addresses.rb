class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zipcode
      t.json :result

      t.timestamps
    end
  end
end
