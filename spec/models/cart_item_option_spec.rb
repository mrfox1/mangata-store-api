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
require 'rails_helper'

RSpec.describe CartItemOption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
