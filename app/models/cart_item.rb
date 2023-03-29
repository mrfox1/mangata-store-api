# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1)
#  product_id :bigint
#  cart_id    :bigint
#  order_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  has_many :cart_item_options, dependent: :destroy

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
