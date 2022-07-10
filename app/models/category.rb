# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  title       :string
#  image       :string
#  category_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  belongs_to :category, optional: true

  has_one :attachment, as: :attachable, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { in: 5..80 }, if: ->{ self.title.present? }

  accepts_nested_attributes_for :attachment, allow_destroy: true
end
