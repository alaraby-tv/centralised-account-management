class Permission < ApplicationRecord
  has_many :requests
  has_many :access_accounts, through: :requests
  has_many :end_users, through: :requests

  validates :name, presence: true
end
