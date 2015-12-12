class Customer < ActiveRecord::Base

  STRING_NUMBER_SPACE_REGEX = /\A[a-zA-Z\d\s]*\z/
  COUNTRY_CODE_INDONESIA = "+62"
  EMAIL_PATTERN = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PASSWORD_PATTERN = /\A((\\w|[\AA-Za-z0-9]){8,})\z/

  validates :first_name, presence: true, 
                         format: { with: STRING_NUMBER_SPACE_REGEX },
                         length: { maximum: 25 }
  validates :last_name, format: { with: STRING_NUMBER_SPACE_REGEX },
                        length: { maximum: 25 }
  validates :mobile_phone, presence: true,
                           numericality: true
  validates :email, presence: true,
                    format: { with: EMAIL_PATTERN },
                    uniqueness: true
  validates :card_id, presence: true
  validates :address, presence: true,
                      length: { maximum: 50 }
  validates :city, presence: true
  validates :country, presence: true
  validates :nationality, presence: true
  validates :password, presence: true,
                       format: { with: PASSWORD_PATTERN },
                       length: { minimum: 8 }

  enum status: [:unverified, :non_active, :active, :blacklist]

  before_validation :replace_country_code_indonesia, :downcase_email

  private

  def replace_country_code_indonesia
    self.mobile_phone.gsub!(COUNTRY_CODE_INDONESIA, "0") if !self.mobile_phone.blank? && self.mobile_phone.start_with?(COUNTRY_CODE_INDONESIA)
  end

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
