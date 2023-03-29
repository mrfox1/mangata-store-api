class ProductOption < ApplicationRecord
  enum option_type: %i[aroma wick]
end
