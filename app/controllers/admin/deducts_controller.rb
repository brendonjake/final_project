class Admin::DeductsController < AdminController
  before_action :set_user

  def create
    @order = Order.new(order_params)
    if @order.save
      if @order.may_pay?
        @order.pay!
        flash[:notice] = 'Create deduct order successfully'
      else
        flash[:alert] = 'Create deduct order failed'
      end
    else
      flash[:alert] = 'Create deduct order failed'
    end
    redirect_to new_deduct_path(@user)
  end

  def new
    @order = Order.new(genre: :deduct)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:coin, :remark).with_defaults(user_id: @user.id, genre: :deduct)
  end
end