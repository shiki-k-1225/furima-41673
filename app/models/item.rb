class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHashアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  # バリデーション
  validates :name, :description, :price, :image, presence: true
  validates :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
