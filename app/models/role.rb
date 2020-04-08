class Role < ApplicationRecord
  has_many :users, inverse_of: :role

  validates :name, presence: true
end
