class Admin::IncreasesController < AdminController
  before_action :set_user

  def create
    @order = Order.new(order_params)
    if @order.save
      if @order.may_pay?
        @order.pay!
        flash[:notice] = 'Create increase order successfully'
      else
        flash[:alert] = 'Create increase order failed'
      end
    else
      flash[:alert] = 'Create increase order failed'
    end
    redirect_to new_increase_path(@user)
  end

  def new
    @order = Order.new(genre: :increase)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:coin, :remark).with_defaults(user_id: @user.id, genre: :increase)
  end
end