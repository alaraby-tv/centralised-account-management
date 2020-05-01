class AccessRequest < ApplicationRecord
  belongs_to :access_account, inverse_of: :access_requests
  belongs_to :end_user, inverse_of: :access_requests
  belongs_to :request, inverse_of: :access_requests
  belongs_to :access_requester, class_name: 'User', inverse_of: :access_requests
  has_many :access_request_events, dependent: :destroy, inverse_of: :access_request
  has_many :access_request_permissions, dependent: :destroy, inverse_of: :access_request
  has_many :permissions, -> { distinct }, through: :access_request_permissions

  validates_uniqueness_of :end_user, scope: :access_account, message: "is assigned to this account already"
  validates :access_requester, :end_user, :access_account, presence: true
  validates :permissions, presence: true, if: :access_account_with_permissions?

  delegate :name, to: :access_account, prefix: true
  delegate :name, to: :end_user, prefix: true
  delegate :name, to: :access_requester, prefix: true
  delegate :email, to: :access_requester, prefix: true
  delegate :name, to: :permission
  delegate :approvable, :approver, :approver_name, to: :access_account
  delegate :requester, :requester_name, to: :request


  STATES = %w[draft submitted resubmitted approved rejected completed cancelled]
  delegate :draft?, :submitted?, :resubmitted?, :approved?, :rejected?, :completed?, :cancelled?, to: :current_state

  def self.submitted_requests
    joins(:access_request_events).merge AccessRequestEvent.with_last_state("submitted")
  end

  def self.approved_requests
    joins(:access_request_events).merge AccessRequestEvent.with_last_state("approved")
  end

  def current_state
    (access_request_events.last.try(:state) || STATES.first).inquiry
  end

  def submit(user)
    if current_state.draft?
      @event = access_request_events.create!(state: "submitted", user_name: user.name)
      AccessRequestMailer.submit(self).deliver
    end
  end

  def resubmit(user)
    if ready_to_resubmit?
      access_request_events.create!(state: "resubmitted", user_name: user.name)
      AccessRequestMailer.resubmit(self).deliver
    end
  end

  def approve(user, comment)
    if ready_to_approve?
      access_request_events.create!(state: "approved", user_name: user.name, comment: comment)
      AccessRequestMailer.approve(self).deliver
    end
  end

  def reject(user, comment)
    if ready_to_approve?
      access_request_events.create!(state: "rejected", user_name: user.name, comment: comment)
      AccessRequestMailer.reject(self).deliver
    end
  end

  def cancel(user, comment)
    if ready_to_cancel?
      access_request_events.create!(state: "cancelled", user_name: user.name, comment: comment) 
      AccessRequestMailer.cancel(self).deliver
    end
  end

  def complete(user)
    if ready_to_complete?
      access_request_events.create!(state: "granted", user_name: user.name) 
      AccessRequestMailer.complete(self).deliver
    end
  end

  def access_account_with_permissions?
    access_account.permissions.any?
  end

  def ready_to_approve?
    current_state.submitted? or current_state.resubmitted?
  end

  def ready_to_complete?
    approvable ? current_state.approved? : ready_to_approve?
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
