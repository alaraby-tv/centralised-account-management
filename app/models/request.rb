class Request < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :requester, optional: true
  belongs_to :access_account
  belongs_to :permission

  STATES = %w[submitted approved rejected cancelled closed]
  delegate :submitted?, :approved?, :rejected?, :closed?, :cancelled?, to: :current_state

  def self.submitted_requests
    joins(:events).merge RequestEvent.with_last_state("submitted")
  end

  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def submit(user)
    events.create!(state: "submitted", user_name: user.name)
    # RequestStatusMailer.new_request_notification(self).deliver
  end

  def approve(user, comment)
    events.create!(state: "approved", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.approved_request_notification(self).deliver
  end

  def reject(user, comment)
    events.create!( state: "rejected", user_name: user.name, comment: comment) if current_state.submitted?
    # RequestStatusMailer.rejected_request_notification(self).deliver
  end

  def close(user)
    events.create!(state: "closed", user_name: user.name) if current_state.approved?
    # RequestStatusMailer.closed_request_notification(self).deliver
  end

  def cancel(user)
    events.create!(state: "cancelled", user_name: user.name)
    # RequestStatusMailer.cancelled_request_notification(self).deliver
  end
end
