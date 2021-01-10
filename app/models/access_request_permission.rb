class AccessRequestPermission < ApplicationRecord
  belongs_to :access_request, optional: true, inverse_of: :access_request_permissions
  belongs_to :permission, optional: true, inverse_of: :access_request_permissions

  validates_uniqueness_of :permission_id, scope: :access_request, message: "is assigned to this access request already"
end
