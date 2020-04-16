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
  delegate :name, to: :end_user, prefix: true
  delegate :name, to: :permission
  delegate :approver, to: :access_account
  delegate :requester, to: :request
  delegate :requester_name, to: :request

  STATES = %w[draft submitted resubmitted approved rejected completed cancelled]
  delegate :draft?, :submitted?, :resubmitted?, :approved?, :rejected?, :completed?, :cancelled?, to: :current_state

  def self.submitted_requests
    joins(:access_request_events).merge RequestEvent.with_last_state("submitted")
  end

  def current_state
    (access_request_events.last.try(:state) || STATES.first).inquiry
  end

  def submit(user)
    @event = access_request_events.create!(state: "submitted", user_name: user.name) if current_state.draft?
    # RequestStatusMailer.new_request_notification(self).deliver
  end

  def resubmit(user)
    access_request_events.create!(state: "resubmitted", user_name: user.name) if ready_to_resubmit?
    # RequestStatusMailer.updated_request_notification(self).deliver
  end

  def approve(user, comment)
    access_request_events.create!(state: "approved", user_name: user.name, comment: comment) if ready_to_approve?
    # RequestStatusMailer.approved_request_notification(self).deliver
  end

  def reject(user, comment)
    access_request_events.create!( state: "rejected", user_name: user.name, comment: comment) if ready_to_approve?
    # RequestStatusMailer.rejected_request_notification(self).deliver
  end

  def cancel(user, comment)
    access_request_events.create!(state: "cancelled", user_name: user.name, comment: comment) if ready_to_cancel?
    # RequestStatusMailer.completed_request_notification(self).deliver
  end

  def complete(user)
    access_request_events.create!(state: "granted", user_name: user.name) if current_state.approved?
    # RequestStatusMailer.completed_request_notification(self).deliver
  end

  def access_account_with_permissions?
    access_account.permissions.any?
  end

  def ready_to_approve?
    current_state.submitted? or current_state.resubmitted?
  end

  def ready_to_resubmit?
    !ready_to_approve? and !current_state.draft?
  end

  def ready_to_cancel?
    !current_state.cancelled? and !current_state.draft?
  end

  def approver?(user)
    user == approver and user != requester
  end

  def owner?(user)
    user == requester
  end
end
