class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @users = User.admin
  end

end
