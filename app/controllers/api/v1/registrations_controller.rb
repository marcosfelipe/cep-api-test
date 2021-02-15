class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {errors: resource.errors}, status: :bad_request
  end

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end
end