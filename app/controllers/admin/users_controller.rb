class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @users = current_client_user
  end

end
