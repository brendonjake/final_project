class Client::AddressesController < ApplicationController
  before_action :authenticate_client_user!
  before_action :set_post, only: [ :edit, :update, :destroy]

  def index
    @addresses = current_client_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_client_user
    if current_client_user.addresses.count >= 5
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    else
      if @address.save
        flash[:notice] = 'Post created successfully'
        redirect_to client_addresses_path
      else
        flash.now[:alert] = 'Post create failed'
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to client_addresses_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to client_addresses_path
  end

  private

  def set_post
    @address = current_client_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:genre, :name, :street_address, :phone_number, :remark, :is_default, :address_region_id, :address_province_id, :address_city_id, :address_barangay_id)
  end
end