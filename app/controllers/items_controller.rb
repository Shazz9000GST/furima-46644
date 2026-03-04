class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_root_unless_editable, only: [:edit, :update]

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

  def edit
    # @item は set_item でセット済み
  end

  def update
    # 画像を何も選ばず更新した場合に画像が消えないようにする
    params[:item].delete(:image) if params.dig(:item, :image).blank?

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  # edit/updateできる条件:自分の出品かつ売却済みでない
  def move_to_root_unless_editable
    return redirect_to root_path unless current_user.id == @item.user_id
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :delivery_time_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end