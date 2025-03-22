class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])

    # 売却済み商品の場合はトップページにリダイレクト（購入機能語実装の為コメントアウト処理）
  # if @item.order.present?
  #   redirect_to root_path
  # end

    redirect_to root_path unless current_user == @item.user
  end

  def update
    @item = Item.find(params[:id])

    # 編集時に画像が未変更の場合、既存の画像を保持
    if params[:item][:image].nil?
      params[:item][:image] = @item.image.blob if @item.image.attached?
    end

    # 商品情報の更新処理
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end