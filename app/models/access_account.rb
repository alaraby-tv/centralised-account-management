class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: :user
  has_many :requests
  has_many :end_users, through: :requests
  has_many :permissions, through: :requests
  has_many :requesters, through: :requests, source: :user


  validates :name, presence: true
end
