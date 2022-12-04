class User < ApplicationRecord
  attr_accessor :password, :password_confirmation, :remove_image

  has_many :sessions, dependent: :destroy

  enum social_type: %I(facebook google)
  enum role: %I(customer admin)

  before_save :encrypt_password
  before_validation :downcase_email

  validates :email, :phone_number, presence: true, unless: ->{ self.social? }
  validates :email,
            uniqueness: {
              case_sensitive: false,
              message: proc { "^#{ I18n.t('errors.email_registered') }" }
            },
            format: {
              with: EMAIL_REGEXP,
              message: proc { "^#{ I18n.t('errors.email_incorrect') }" }
            },
            length: { in: 6..48 }, presence: true, if: ->{ self.email.present? }

  validates :phone_number,
            uniqueness: {
              case_sensitive: false,
              message: proc { "^#{ I18n.t('errors.phone_number_registered') }" }
            },
            format: { with: /\+\d{9,}/, message: proc { I18n.t('errors.is_incorrect') } },
            if: ->{ self.phone_number.present? }

  validates :first_name, :last_name, presence: true
  validates :first_name, length: { in: 4..48 }, if: ->{ self.first_name.present? }
  validates :last_name, length: { in: 4..48 }, if: ->{ self.last_name.present? }
  validates :password, presence: true, confirmation: true, length: { in: 6..48 }, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?

  def social?
    self.social_type.present?
  end

  def encrypt(string)
    secure_hash("#{ string }--#{ self.salt }")
  end

  def authenticate?(password)
    self.encrypted_password == self.encrypt(password)
  end

  def info
    profile = self.attributes
                  .symbolize_keys
                  .slice(
                    :id,
                    :email,
                    :phone_number,
                    :full_name,
                    :state,
                    :city,
                    :address,
                    :newsletter,
                    :created_at,
                    :updated_at
                  )

    profile[:avatar_image] = self.image if self['image'].present?
    profile[:social_type] = self.social_type if self.social_type.present?
    profile
  end

  private

  def validate_password?
    self.new_record? && self.social_type.blank? ||
      self.password.present? || self.password_confirmation.present?
  end

  def downcase_email
    self.email.downcase! if self.email.present?
  end

  def encrypt_password
    self.salt = make_salt if self.salt.blank?
    self.encrypted_password = self.encrypt(self.password) if self.password.present?
  end

  def make_salt
    SecureRandom.hex 32
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest string
  end
end
