class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def check_token
    render json: current_user, status: :ok
  end

end
