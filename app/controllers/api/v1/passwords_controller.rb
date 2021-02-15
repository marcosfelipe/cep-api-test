class Api::V1::PasswordsController < Devise::PasswordsController
  # Be sure to enable JSON.
  respond_to :json

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: {success: I18n.t("devise.password.send_instructions")}, status: :ok
    else
      render json: {errors: [I18n.t("login.email_not_found")]}, status: :not_found
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      binding.pry
      if Devise.sign_in_after_reset_password && params[:block].nil?
        resource.after_database_authentication
        sign_in(resource, :bypass => true)
        render json: {success: true, user: resource }
      else
        render json: {success: false, response: I18n.t("login.auth_error") }
      end
    else
      render json: {errors: [I18n.t("login.token_expired")]}, status: :unprocessable_entity
    end
  end

end