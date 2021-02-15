require 'rails_helper'

RSpec.describe "Api::V1::Registrations", type: :request do
  describe 'POST api/v1/users/sign_up' do
    url = '/api/v1/users/sign_up'

    it 'create account' do
      post url, params: {user: {email: Faker::Internet.free_email, password: '123456', name: Faker::Name.name}}
      expect(response).to have_http_status(:ok)
    end

    it 'without params' do
      post url
      expect(response).to have_http_status(:not_found)
    end

    it 'invalid params' do
      post url, params: {user: {email: 'teste', password: '123'}}
      expect(response).to have_http_status(:bad_request)
    end

  end
end
