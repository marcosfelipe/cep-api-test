require 'rails_helper'

RSpec.describe "Application", type: :request do

  it 'Check API is on' do
    get '/'
    expect(response).to have_http_status(:ok)
  end

end
