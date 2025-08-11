class Match < ApplicationRecord
  belongs_to :application_one, class_name: 'Application'
  belongs_to :application_two, class_name: 'Application'
  belongs_to :admin
  
  validates :matched_at, presence: true
  validate :applications_are_different
  validate :applications_are_approved
  
  before_validation :set_matched_at, on: :create
  after_create :update_application_statuses
  
  scope :recent, -> { order(matched_at: :desc) }
  
  private
  
  def applications_are_different
    return unless application_one && application_two
    
    if application_one_id == application_two_id
      errors.add(:application_two, "cannot be the same as the first application")
    end
  end
  
  def applications_are_approved
    errors.add(:application_one, "must be approved") unless application_one&.status == 'approved'
    errors.add(:application_two, "must be approved") unless application_two&.status == 'approved'
  end
  
  def set_matched_at
    self.matched_at ||= Time.current
  end
  
  def update_application_statuses
    application_one.update!(status: 'matched')
    application_two.update!(status: 'matched')
  end
end
