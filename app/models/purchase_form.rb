class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token,
                :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  validates :prefecture_id, numericality: { other_than: 0 }  # 「---」が0の想定

  # 保存処理(複数テーブル)
  def save
    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create!(
        purchase_id: purchase.id,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        addresses: addresses,
        building: building,
        phone_number: phone_number
      )
    end
  end
end