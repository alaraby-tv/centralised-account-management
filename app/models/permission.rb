class Permission < ApplicationRecord
  belongs_to :access_account
  has_many :access_request_permissions
  has_many :access_requests, through: :access_request_permissions

  validates :name, presence: true
end
