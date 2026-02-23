class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_time

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :delivery_time_id
    validates :price
  end

  # 「---」(id=0) を弾く（エラーメッセージが重複しにくいように can't be blank に寄せる）
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id,
            numericality: { other_than: 0, message: "can't be blank" }

  # 価格：半角数値（整数）かつ 300〜9,999,999
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }
end