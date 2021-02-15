require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.create(:user) }
  it 'has a valid factory' do
    expect(@user).to be_valid
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  it 'generate JTI' do
    expect(@user.jwt_payload).to eq({"jti"=>@user.jti, :jti=>@user.jti, :usr=>@user.id})
  end
end
