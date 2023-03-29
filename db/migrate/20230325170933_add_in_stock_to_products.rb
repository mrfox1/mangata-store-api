class AddInStockToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :in_stock, :boolean
  end
end
