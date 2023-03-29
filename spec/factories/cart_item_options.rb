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
FactoryBot.define do
  factory :cart_item_option do
    product_option { nil }
    cart_item { nil }
  end
end
