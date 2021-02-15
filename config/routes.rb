Rails.application.routes.draw do

  root 'application#api'
  devise_for :users, skip: [:registrations, :sessions, :passwords]
  devise_scope :user do
    post   "api/v1/users/sign_up"  => "api/v1/registrations#create"
    post   "api/v1/users/sign_in"  => "api/v1/sessions#create"
    delete "api/v1/users/sign_out" => "api/v1/sessions#destroy"
    patch  "api/v1/users/password" => "api/v1/passwords#update"
    post   "api/v1/users/password" => "api/v1/passwords#create"
  end

  namespace 'api' do
    namespace 'v1' do
      get 'check_token' => 'users#check_token'
      get 'zipcode_search/:zipcode' => 'zipcodes#search'
    end
  end
end
