require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do

  describe 'POST api/v1/users/sign_in' do
    url = '/api/v1/users/sign_in'

    it 'unauthorized' do
      post url
      expect(response).to have_http_status(:unauthorized)
    end

    it 'invalid user' do
      post url, params: {user:{ email: 'teste@teste.com', password: '123456'}}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'loggin success' do
      user  = @user = FactoryGirl.create(:user, password: '123456')

      post url, params: {user:{ email: user.email, password: '123456'}}
      expect(response.headers['Authorization']).to be_present
    end

  end
end
