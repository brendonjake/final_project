class Client::SharesController < ApplicationController
  def index
    @shares = Winner.published
  end

  def show
    @share = Winner.published.find(params[:id])
  end
end
