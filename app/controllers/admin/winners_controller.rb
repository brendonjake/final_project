class Admin::WinnersController < AdminController

  def index
    @winners = Winner.all
    # filtering_params(params).each do |key, value|
    #   @winners = @winners.public_send("filter_by_#{key}", value) if value.present?
  end

  def show
  end

  def submit
    @winner = Winner.find(params[:winner_id])
    if @winner.may_submit?
      flash[:notice] = 'Submitted successfully'
      @winner.submit!
    end
    redirect_to admin_winners_path
  end

  def pay
    @winner = Winner.find(params[:winner_id])
    if @winner.may_pay?
      flash[:notice] = 'Paid successfully'
      @winner.pay!
    end
    redirect_to admin_winners_path
  end

  def ship
    @winner = Winner.find(params[:winner_id])
    if @winner.may_ship?
      flash[:notice] = 'Shipped successfully'
      @winner.ship!
    end
    redirect_to admin_winners_path
  end

  def deliver
    @winner = Winner.find(params[:winner_id])
    if @winner.may_deliver?
      flash[:notice] = 'Delivered successfully'
      @winner.deliver!
    end
    redirect_to admin_winners_path
  end

  def publish
    @winner = Winner.find(params[:winner_id])
    if @winner.may_publish?
      flash[:notice] = 'Published successfully'
      @winner.publish!
    end
    redirect_to admin_winners_path
  end

  def remove_publish
    @winner = Winner.find(params[:winner_id])
    if @winner.may_remove_publish?
      flash[:notice] = 'Removed Publish successfully'
      @winner.remove_publish!
    end
    redirect_to admin_winners_path
  end

  def update


  end
  # private
  #
  # def filtering_params(params)
  #   params.slice(:serial_number, :email, :state, :start_date, :end_date)
  # end
end
# end
