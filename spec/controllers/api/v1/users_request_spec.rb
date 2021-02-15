require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::Users", type: :request do
  describe 'GET api/v1/check_token' do
    url = '/api/v1/check_token'

    it 'success' do
      user = user  = @user = FactoryGirl.create(:user)
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      get url, headers: auth_headers
      expect(response).to have_http_status(:ok)
    end

    it 'error' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9' }

      get url, headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

  end
end
