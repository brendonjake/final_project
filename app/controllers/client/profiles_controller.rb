class Client::ProfilesController < ApplicationController
  before_action :authenticate_client_user!

  def show
    if params[:history] == 'order'
      @orders = current_client_user.orders
    elsif params[:history] == 'lottery'
      @bets = current_client_user.bets
    elsif params[:history] == 'winner'
      @winners = current_client_user.winners
    elsif params[:history] == 'invite'
      @children = current_client_user.children
    end
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
      @client.update(update_with_password_params)
      flash[:notice] = 'Updated successfully'
      redirect_to client_profiles_path
    end
  end

  def cancel
    @order = Order.find(params[:id])
    if @order.may_cancel?
      flash[:notice] = 'Cancelled successfully'
      @order.cancel!
    end
    redirect_to client_profiles_path
  end

  private

  def update_without_password_params
    params.require(:user).permit(:phone, :username)
  end

  def update_with_password_params
    params.require(:user).permit(:phone, :username, :password)
  end
end