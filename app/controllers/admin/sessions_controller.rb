# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  layout "admin"

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def create
    user = User.find_by(email: params[:admin_user][:email])
    if user&.admin?
      super
    else
      flash[:alert] = "Wrong email or password"
      redirect_to new_admin_user_session_path
    end
    # render json: params
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
    admin_root_path

  end
end
