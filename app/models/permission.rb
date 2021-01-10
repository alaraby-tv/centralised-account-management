class Permission < ApplicationRecord
  has_many :access_request_permissions, inverse_of: :permission, dependent: :destroy
  has_many :access_requests, through: :access_request_permissions
  has_many :access_account_permissions, inverse_of: :permission, dependent: :destroy
  has_many :access_accounts, through: :access_account_permissions

  validates :name, presence: true
end
