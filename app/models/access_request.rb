class AccessRequest < ApplicationRecord
  belongs_to :access_account
  belongs_to :request
  has_many :access_request_permissions
  has_many :permissions, through: :access_request_permissions
  accepts_nested_attributes_for :access_request_permissions,
                                allow_destroy: true,
                                reject_if: proc { |att| att['permission_id'].blank? }
end
