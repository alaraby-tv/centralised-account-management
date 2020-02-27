class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: "User"
  has_many :access_account_permissions
  has_many :permissions, through: :access_account_permissions
  has_many :access_requests
  has_many :requests, through: :access_requests


  validates :name, presence: true
end
