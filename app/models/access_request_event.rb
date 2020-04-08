class AccessRequestEvent < ApplicationRecord
  belongs_to :access_request, inverse_of: :access_request_events

  def self.with_last_state(state)
    order("id desc").where(state: state, id: select('MAX(id)').group(:access_request_id))
  end
end
