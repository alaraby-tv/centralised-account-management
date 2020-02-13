class Role < ApplicationRecord
  has_many :users
  has_many :end_users

  validates :name, presence: true
end
