class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_item, only: [ :edit, :update, :destroy]
  def index
    @items = Item.includes(:categories).all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Post created successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
    # render json: params
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets, :state, :batch_count, :online_at, :offline_at, :start_at, :status, category_ids: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

