class Admin::ItemsController < AdminController
  before_action :authenticate_admin_user!
  before_action :set_item, only: [ :edit, :update, :destroy, :start, :pause, :end, :cancel]
  def index
    @items = Item.includes(:categories).all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Item create failed'
      render :new, status: :unprocessable_entity
    end
    # render json: params
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Item update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = 'Item destroyed successfully'
    redirect_to admin_items_path
  end

  def start
    if @item.may_start?
      flash[:notice] = 'Start successfully'
      @item.start!
    end
    redirect_to admin_items_path
  end

  def pause
    if @item.may_pause?
      flash[:notice] = 'Paused successfully'
      @item.pause!
    end
    redirect_to admin_items_path
  end

  def end
    if @item.may_end?
      flash[:notice] = 'Ended successfully'
      @item.end!
    end
    redirect_to admin_items_path
  end

  def cancel
    if @item.may_cancel?
      flash[:notice] = 'Cancelled successfully'
      @item.cancel!
    end
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets, :state, :batch_count, :online_at, :offline_at, :start_at, :status, category_ids: [])
  end

  def set_item
    @item = Item.find(params[:id] || params[:item_id])
  end
end

