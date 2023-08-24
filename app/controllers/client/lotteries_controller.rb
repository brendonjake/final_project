class Client::LotteriesController < ApplicationController
  before_action :authenticate_client_user!, except: :index
  def index
    @items = Item.active.starting.where("offline_at >= (?) AND online_at <= (?)", Date.current, Date.current)
    @items = @items.includes(:categories).where(categories: { id: params[:category] }) if params[:category].present?
  end

  def show
    @item = Item.find(params[:id])
    @bet = Bet.new
    @bets = current_client_user.bets.where(item: @item, batch_count: @item.batch_count)
    @progress = (Bet.where(item: @item, batch_count: @item.batch_count).count/@item.minimum_bets.to_f) * 100
  end

  def create
    bet_counts = params[:bet][:bet_count]
    bet_counts.to_i.times do
      bet = Bet.create(batch_count: params[:item_batch_count],
                       user_id: current_client_user.id, item_id: params[:item_id])
    end
    flash[:notice] = 'Bet Successfully'
    redirect_to client_lottery_path(id: params[:item_id])
  end
end