require 'rails_helper'

RSpec.describe AddressCreatorJob, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'creates an address' do
    address = { street: 'test', address: 'test', neighborhood: 'test', zipcode: '88888888' }
    expect do
      described_class.perform_now(user_id: user.id, address_attributes: address)
    end.to change { Address.count }.by 1
  end

  it 'cant create an address without an user' do
    expect do
      described_class.perform_now({})
    end.to raise_error(described_class::UserNotFoundError)
  end

  it 'cant create an address without address attributes' do
    expect do
      described_class.perform_now(user_id: user.id)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
