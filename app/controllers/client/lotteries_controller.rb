class Client::LotteriesController < ApplicationController

  def index
    @items = Item.active.starting.where("offline_at >= (?) AND online_at <= (?)", Date.current, Date.current)
    @items = @items.includes(:categories).where(categories: {id: params[:category] }) if params[:category].present?
  end

end