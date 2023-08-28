class Client::PrizeController < ApplicationController

  def show
    @winner = Winner.find(params[:id])
  end

  def update
    @winner = Winner.find(params[:id])
    if @winner.update(address_id: params[:winner][:address_id])
      @winner.claim!
      flash[:notice] = "Successfully chose an Address"
    else
      flash[:alert] = "Update Failed"
    end
    redirect_to client_profiles_path
  end

end
