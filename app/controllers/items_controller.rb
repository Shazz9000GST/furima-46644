# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.with_attached_image.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :delivery_time_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end