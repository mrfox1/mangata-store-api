class User < ApplicationRecord
  attr_accessor :password, :password_confirmation, :remove_image

  has_many :sessions, dependent: :destroy

  enum role: %I[customer admin]

  before_save :encrypt_password
  before_validation :downcase_email

  validates :email, :phone_number, presence: true, unless: -> { social? }
  validates :email,
            uniqueness: {
              case_sensitive: false,
              message: proc { ": #{I18n.t('errors.email_registered')}" }
            },
            format: {
              with: EMAIL_REGEXP,
              message: proc { ": #{I18n.t('errors.email_incorrect')}" }
            },
            length: { in: 6..48 }, presence: true, if: -> { email.present? }

  validates :phone_number,
            uniqueness: {
              case_sensitive: false,
              message: proc { ": #{I18n.t('errors.phone_number_registered')}" }
            },
            format: { with: /\d[0-9]\)*\z/, message: proc { I18n.t('errors.is_incorrect') } },
            length: { minimum: 10, maximum: 15 },
            if: -> { phone_number.present? }

  validates :first_name, :last_name, presence: true
  validates :first_name, length: { in: 4..48 }, if: -> { first_name.present? }
  validates :last_name, length: { in: 4..48 }, if: -> { last_name.present? }
  validates :password, presence: true, confirmation: true, length: { in: 6..48 }, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?

  def social?
    social_type.present?
  end

  def encrypt(string)
    secure_hash("#{string}--#{salt}")
  end

  def authenticate?(password)
    encrypted_password == encrypt(password)
  end

  def info
    profile = self.attributes.symbolize_keys.slice(:id, :email, :phone_number, :first_name,
                    :last_name, :state, :city, :address, :role, :created_at, :updated_at
                  )

    profile[:avatar_image] = self.image if self['image'].present?
    # profile[:social_type] = self.social_type if self.social_type.present?
    profile
  end

  private

  def validate_password?
    new_record? && social_type.blank? || password.present? || password_confirmation.present?
  end

  def downcase_email
    email.downcase! if email.present?
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
