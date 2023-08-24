class Client::ShopsController < ApplicationController
  before_action :authenticate_client_user!, except: [:index]

  def index
    @offers = Offer.active
  end

  def show
    @offer = Offer.find(params[:id])
    @order = Order.new
  end

  def create
    @order = Order.new
    @offer = Offer.find(params[:offer_id])
    @order.user = current_client_user
    @order.genre = :deposit
    @order.amount = @offer.amount
    @order.coin = @offer.coin
    @order.offer = @offer
    if @order.save
      flash[:notice] = 'Ordered Successfully'
      redirect_to client_shops_path
    end
  end
end