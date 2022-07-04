if Rails.env.development?
  Category.create(title: 'Candles')
  Category.create(title: 'Perfumes')
end
