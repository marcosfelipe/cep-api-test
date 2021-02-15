require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:address)).to be_valid
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :zipcode }
    it { is_expected.to validate_presence_of :result }
  end
end
