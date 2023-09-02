class Admin::OrdersController < AdminController

  def index
    @orders = Order.all
    filtering_params(params).each do |key, value|
      @orders = @orders.public_send("filter_by_#{key}", value) if value.present?
    end
    @total_coins = @orders.sum(&:coin)
    @total_amount = @orders.sum(&:amount)
    @orders = @orders.page(params[:page]).per(5)
    @subtotal_coins = @orders.sum(&:coin)
    @subtotal_amount = @orders.sum(&:amount)
  end

  def create

  end

  def new

  end

  def pay
    @order = Order.find(params[:order_id])
    if @order.may_pay?
      flash[:notice] = 'Paid successfully'
      @order.pay!
    else
      flash[:alert] = 'Pay failed'
    end
    redirect_to admin_orders_path
  end

  def cancel
    @order = Order.find(params[:order_id])
    if @order.may_cancel?
      flash[:notice] = 'Cancelled successfully'
      @order.cancel!
    else
      flash[:alert] = 'Cancel failed'
    end
    redirect_to admin_orders_path
  end

  private

  def filtering_params(params)
    params.slice(:serial_number, :email, :genre, :state, :offer, :start_date, :end_date)
  end
end