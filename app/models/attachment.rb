# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string
#  attachable_id   :bigint
#  attachment      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  validates :attachment, presence: true

  mount_uploader :attachment, AttachmentUploader
end
# TODO: add fix price and discount
# add option discount
# choise max discount