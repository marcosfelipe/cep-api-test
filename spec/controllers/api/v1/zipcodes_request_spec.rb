require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::Zipcodes", type: :request do
  before do
    user = FactoryGirl.create(:user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    @adress = FactoryGirl.create(:address)
  end
  describe 'GET api/v1/zipcode_search/:zipcode' do

    url = '/api/v1/zipcode_search'

    it 'success by api' do
      stub_request(:get, "http://cep.la/85020706").
        with(
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: '{
          "cep": "85020706",
          "uf": "PR",
          "cidade": "Guarapuava",
          "bairro": "Boqueirão",
          "logradouro": "Rua Antônio Carlos Cúnico"
        }', headers: {})
      get url + '/85020706', headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end

    it 'get success by db' do
      get url + "/#{@adress.zipcode}", headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end

    it 'nonexistent zip code ' do
      get url + '/00000000', headers: @auth_headers
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'invalid zipcode' do
      get url + '/abc125', headers: @auth_headers
      expect(response).to have_http_status(:bad_request)
    end

  end

  describe 'Mock timeout' do
    before do
      stub_request(:get, "http://cep.la/85010210").
        with(
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Ruby'
          }).to_timeout
    end

    it 'timeout error' do
      get '/api/v1/zipcode_search/85010210', headers: @auth_headers
      expect(response).to have_http_status(:request_timeout)
    end
  end
end
