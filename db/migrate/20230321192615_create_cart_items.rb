class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 1
      t.references :product
      t.references :cart
      t.references :order

      t.timestamps
    end
  end
end
