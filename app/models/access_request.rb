class AccessRequest < ApplicationRecord
  belongs_to :access_account
  belongs_to :request
  has_many :access_request_permissions
  has_many :permissions, through: :access_request_permissions
end
