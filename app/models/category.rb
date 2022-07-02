class Category < ApplicationRecord
  belongs_to :category, optional: true

  validates :title, presence: true
  validates :title, length: { in: 5..80 }, if: ->{ self.title.present? }
end
