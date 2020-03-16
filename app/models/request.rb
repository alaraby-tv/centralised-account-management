class Request < ApplicationRecord
  belongs_to :end_user
  belongs_to :requester, class_name: 'User'
  has_many :request_events
  has_many :access_requests
  has_many :access_accounts, through: :access_requests
  accepts_nested_attributes_for :access_requests,
                                allow_destroy: true,
                                reject_if: :all_blank 
end
