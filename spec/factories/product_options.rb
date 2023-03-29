# == Schema Information
#
# Table name: product_options
#
#  id           :bigint           not null, primary key
#  option_type  :integer
#  option_value :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :product_option do
    option_type { 0 }
    option_value { 'Burbon' }
  end
end
