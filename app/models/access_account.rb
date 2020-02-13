class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: "User"
  has_many :end_users, through: :requests
  has_many :account_permissions
  has_many :permissions, through: :account_permissions
  has_many :access_requests
  has_many :requests, through: :access_requests
  has_many :requesters, through: :requests, source: :user


  validates :name, presence: true
end
