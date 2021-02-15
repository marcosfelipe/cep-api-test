class Api::V1::ZipcodesController < ApplicationController
  before_action :authenticate_user!

  def search
    zip = params[:zipcode]
    if valid_zip(zip)
      request_service = RequestService.new(zip, current_user)
      res = request_service.result

      render json: res[0], status: res[1]
    else
      render json: {error: {message: 'CEP INVÁLIDO'}}, status: :bad_request
    end
  end

  private
  def valid_zip(zip)
    /^\d{5}-?\d{3}$/.match zip
  end

end