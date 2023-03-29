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
require 'rails_helper'

RSpec.describe ProductOption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
