class Client::FeedbackController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_winner

  def show
  end

  def update
    winner_params = params.require(:winner).permit(:picture,:comment)
    if @winner.update(winner_params)
      @winner.share!
      flash[:notice] = "Created Successfully"
    else
      flash[:alert] = "Failed"

    end
    redirect_to client_profiles_path
  end

  private

  def set_winner
    @winner = current_client_user.winners.delivered.find(params[:id])
  end
end