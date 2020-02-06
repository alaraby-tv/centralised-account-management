class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: "User"

  validates :name, presence: true
end
