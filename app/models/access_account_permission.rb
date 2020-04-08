class AccessAccountPermission < ApplicationRecord
  belongs_to :access_account, optional: true, inverse_of: :access_account_permissions
  belongs_to :permission, optional: true

  validates_uniqueness_of :permission_id, scope: :access_account, message: "is assigned to this account already"
end
