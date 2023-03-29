class CreateCartItemOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_item_options do |t|
      t.references :product_option, null: false, foreign_key: true
      t.references :cart_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
