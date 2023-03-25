# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  first_name   :string
#  last_name    :string
#  address      :text
#  phone_number :string
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Order < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
end
