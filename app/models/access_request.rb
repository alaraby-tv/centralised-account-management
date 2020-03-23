class AccessRequest < ApplicationRecord
  before_save :find_or_create_permission
  belongs_to :access_account
  belongs_to :end_user
  belongs_to :request
  has_many :access_request_events
  has_and_belongs_to_many :permissions
  accepts_nested_attributes_for :permissions,
                                allow_destroy: true,
                                reject_if: proc { |att| att['name'].blank? }

  STATES = %w[submitted approved rejected cancelled closed]
  delegate :submitted?, :approved?, :rejected?, :closed?, :cancelled?, to: :current_state

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

  def close(user)
    access_request_events.create!(state: "closed", user_name: user.name) if current_state.approved?
    # RequestStatusMailer.closed_request_notification(self).deliver
  end

  def cancel(user)
    access_request_events.create!(state: "cancelled", user_name: user.name)
    # RequestStatusMailer.cancelled_request_notification(self).deliver
  end

  def access_account_name
    access_account.name
  end

  private

  def find_or_create_permission
    self.permissions = self.permissions.map do |permission|
      Permission.find_or_create_by(name: permission.name)
    end
  end
end
