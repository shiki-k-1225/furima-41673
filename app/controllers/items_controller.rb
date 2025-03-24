class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:purchase).order(created_at: :desc) # N+1問題を防ぐためincludesを追加
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @item は before_action で設定済み
  end

  def edit
    # @item は before_action で設定済み
    redirect_to root_path unless current_user == @item.user
  end

  def update
    # @item は before_action で設定済み
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end