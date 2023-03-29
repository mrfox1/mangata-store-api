class AddFieldsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price, :bigint
    add_column :products, :discount, :integer
  end
end
