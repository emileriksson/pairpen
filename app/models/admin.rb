class Admin < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :name, presence: true
  
  has_many :matches, dependent: :destroy
end
