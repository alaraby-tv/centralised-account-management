class RequestEvent < ApplicationRecord
  belongs_to :request
  attr_accessor :state

  validates :request_id, presence: true
  validates_inclusion_of :state, in: Request::STATES

  def self.with_last_state(state)
    order("id desc").where(state: state, id: select('MAX(id)').group(:request_id))
  end
end
