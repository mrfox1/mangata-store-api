# == Schema Information
#
# Table name: cart_item_options
#
#  id                :bigint           not null, primary key
#  product_option_id :bigint           not null
#  cart_item_id      :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class CartItemOption < ApplicationRecord
  belongs_to :product_option
  belongs_to :cart_item
end
