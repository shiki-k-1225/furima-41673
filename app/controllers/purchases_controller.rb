require 'payjp'

class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item # PAY.JP決済処理
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_address_params
    params.permit(:postal_code, :prefecture_id, :city, :house_number, :building, :phone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid
    # 自身が出品した商品、または売却済み商品の購入画面へのアクセスを禁止
    if @item.purchase.present? || current_user == @item.user
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price, # 商品の価格
      card: purchase_address_params[:token], # カードトークン
      currency: 'jpy' # 通貨
    )
  end
end