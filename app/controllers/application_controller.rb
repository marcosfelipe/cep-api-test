class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing,       with: -> { render_400  }

  def api
    render json: 'API online', status: :ok
  end

  def render_400
    render json: {errors: "Parametros inválidos"}, status: :not_found
  end

end
