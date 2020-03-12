class Permission < ApplicationRecord
  has_and_belongs_to_many :access_requests
  has_and_belongs_to_many :access_accounts

  validates :name, presence: true
end
