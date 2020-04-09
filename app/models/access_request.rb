class AccessRequest < ApplicationRecord
  belongs_to :access_account, inverse_of: :access_requests
  belongs_to :end_user, inverse_of: :access_requests
  belongs_to :request, inverse_of: :access_requests
  has_many :access_request_events, dependent: :destroy, inverse_of: :access_request
  has_many :access_request_permissions, dependent: :destroy, inverse_of: :access_request
  has_many :permissions, -> { distinct }, through: :access_request_permissions

  validates_uniqueness_of :end_user, scope: :access_account, message: "is assigned to this account already"
  validates :permissions, presence: true, if: :access_account_with_permissions?

  delegate :name, to: :access_account, prefix: true

  STATES = %w[draft submitted approved rejected completed]
  delegate :draft?, :submitted?, :approved?, :rejected?, :completed?, to: :current_state

  def self.submitted_requests
    joins(:access_request_events).merge RequestEvent.with_last_state("submitted")
  end

  def current_state
    (access_request_events.last.try(:state) || STATES.first).inquiry
  end

  def submit(user)
    access_request_events.create!(state: "submitted", user_name: user.name)
    # RequestStatusMailer.new_request_notification(self).deliver
  end

  def approve(user, comment)
    access_request_events.create!(state: "approved", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.approved_request_notification(self).deliver
  end

  def reject(user, comment)
    access_request_events.create!( state: "rejected", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.rejected_request_notification(self).deliver
  end

  def complete(user)
    access_request_events.create!(state: "completed", user_name: user.name) unless current_state.rejected?
    # RequestStatusMailer.completed_request_notification(self).deliver
  end

  def label_class
    case current_state
    when 'submitted'
      'primary'
    when 'approved'
      'warning'
    when 'rejected'
      'danger'
    when 'completed'
      'success'
    else
      'info'
    end
  end

  def access_account_with_permissions?
    access_account.permissions.any?
  end
end
