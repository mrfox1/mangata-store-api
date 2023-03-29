class CreateProductOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_options do |t|
      t.integer :option_type
      t.string :option_value

      t.timestamps
    end
  end
end
