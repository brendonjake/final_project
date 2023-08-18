class Admin::BetsController < ApplicationController

  def index
    @bets = Bet.where(nil)
    filtering_params(params).each do |key, value|
      @bets = @bets.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  def cancel
    @bet = Bet.find(params[:bet_id])
    if @bet.may_cancel?
      flash[:notice] = 'Cancelled successfully'
      @bet.cancel!
    end
    redirect_to admin_bets_path
  end

  private

  def filtering_params(params)
    params.slice(:serial_number, :item_name, :email, :state, :start_date, :end_date)
  end
 end
