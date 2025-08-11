class Application < ApplicationRecord
  STATUSES = %w[unverified pending approved rejected matched].freeze
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :application_text, presence: true, length: { minimum: 50, maximum: 1000 }
  validates :status, inclusion: { in: STATUSES }
  validates :verification_token, presence: true, uniqueness: true
  validates :status_token, presence: true, uniqueness: true
  
  has_many :matches_as_first, class_name: 'Match', foreign_key: 'application_one_id'
  has_many :matches_as_second, class_name: 'Match', foreign_key: 'application_two_id'
  
  before_validation :generate_tokens, on: :create
  
  scope :verified, -> { where.not(verified_at: nil) }
  scope :unverified, -> { where(verified_at: nil) }
  scope :by_status, ->(status) { where(status: status) }
  
  def verified?
    verified_at.present?
  end
  
  def matched?
    status == 'matched'
  end
  
  def match
    matches_as_first.first || matches_as_second.first
  end
  
  private
  
  def generate_tokens
    self.verification_token ||= SecureRandom.urlsafe_base64(32)
    self.status_token ||= SecureRandom.urlsafe_base64(32)
  end
end
