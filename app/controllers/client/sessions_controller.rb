# frozen_string_literal: true

class Client::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def create
    user = User.find_by(email: params[:client_user][:email])
    if user&.client?
      super
    else
      flash[:alert] = "Wrong email or password"
      redirect_to new_client_user_session_path
    end
  end
  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    client_root_path

  end
end
