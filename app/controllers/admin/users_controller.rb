class Admin::UsersController < AdminController
  before_action :authenticate_admin_user!

  def index
    @users = User.client
  end

end
