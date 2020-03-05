class Permission < ApplicationRecord
  has_many :access_request_permissions
  has_many :access_requests, through: :access_request_permissions
  has_and_belongs_to_many :access_accounts

  validates :name, presence: true
end
