# == Schema Information
#
# Table name: product_options
#
#  id           :bigint           not null, primary key
#  option_type  :integer
#  option_value :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ProductOption < ApplicationRecord
  enum option_type: %i[aroma wick]

  has_many :cart_item_options, dependent: :destroy
end
