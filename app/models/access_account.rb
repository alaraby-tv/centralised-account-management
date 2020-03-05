class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: "User"
  has_many :access_requests
  has_many :requests, through: :access_requests
  has_and_belongs_to_many :permissions
  accepts_nested_attributes_for :permissions,
                                allow_destroy: true,
                                reject_if: proc { |att| att['name'].blank? }


  validates :name, presence: true
end
