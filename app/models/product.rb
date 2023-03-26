# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :bigint
#  discount    :integer
#  in_stock    :boolean
#
class Product < ApplicationRecord
  belongs_to :category

  has_many :attachment, as: :attachable, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :title, :category_id, :description, :price, :in_stock, presence: true
  validates :title, length: { in: 6..120 }
  validates :discount, minimum: 0, maximum: 100
end
