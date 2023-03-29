# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :bigint
#  discount    :integer
#  in_stock    :boolean
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  subject {
    described_class.new(title: 'Soy Candle 250ml',
                        description: "Lorem ipsum",
                        category_id: create(:category).id,
                        price: 1000,
                        discount: 50,
                        in_stock: true)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is not valid with incorrect title" do
    subject.title = 'title'
    expect(subject).to_not be_valid
  end
  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a category" do
    subject.category_id = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a in_stock" do
    subject.in_stock = nil
    expect(subject).to_not be_valid
  end
  it "is not valid with discount from incorrect range" do
    subject.discount = 105
    expect(subject).to_not be_valid
  end
end
