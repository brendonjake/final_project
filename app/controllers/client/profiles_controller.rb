class Client::ProfilesController < ApplicationController
  before_action :authenticate_client_user!

  def show
  end

  def edit
    @client = current_client_user
  end

  def update
    @client = current_client_user
    if @client.update(update_without_password_params)
      flash[:notice] = 'Updated successfully'
      redirect_to client_profiles_path
    else
      @client.update(update_with_password_params  )
      flash[:notice] = 'Updated successfully'
      redirect_to client_profiles_path
    end
  end


  private

  def update_without_password_params
    params.require(:user).permit(:phone, :username)
  end

  def update_with_password_params
    params.require(:user).permit(:phone, :username, :password)
  end
end