if Rails.env.development?
  Category.create(title: 'Candles', attachment_attributes: { remote_attachment_url: 'https://www.ikea.com/gb/en/images/products/fenomen-unscented-block-candle-natural__0904463_pe586190_s5.jpg' })
  Category.create(title: 'Perfumes', attachment_attributes: { remote_attachment_url: 'https://irecommend.ru/sites/default/files/product-images/158247/HZKrJ6tS5mPLe15FiyM1DA.png' })
end
