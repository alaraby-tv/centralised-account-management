class Request < ApplicationRecord
  belongs_to :end_user
  belongs_to :requester, class_name: 'User'
  has_many :request_events
  has_many :access_requests
  has_many :access_accounts, through: :access_requests
  accepts_nested_attributes_for :access_requests,
                                allow_destroy: true,
                                reject_if: proc { |att| att['access_account_id'].blank? } 

  STATES = %w[submitted approved rejected cancelled closed]
  delegate :submitted?, :approved?, :rejected?, :closed?, :cancelled?, to: :current_state

  def self.submitted_requests
    joins(:request_events).merge RequestEvent.with_last_state("submitted")
  end

  def current_state
    (request_events.last.try(:state) || STATES.first).inquiry
  end

  def submit(user)
    request_events.create!(state: "submitted", user_name: user.name)
    # RequestStatusMailer.new_request_notification(self).deliver
  end

  def approve(user, comment)
    request_events.create!(state: "approved", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.approved_request_notification(self).deliver
  end

  def reject(user, comment)
    request_events.create!( state: "rejected", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.rejected_request_notification(self).deliver
  end

  def close(user)
    request_events.create!(state: "closed", user_name: user.name) if current_state.approved?
    # RequestStatusMailer.closed_request_notification(self).deliver
  end

  def cancel(user)
    request_events.create!(state: "cancelled", user_name: user.name)
    # RequestStatusMailer.cancelled_request_notification(self).deliver
  end
end
