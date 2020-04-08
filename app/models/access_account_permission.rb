class AccessAccountPermission < ApplicationRecord
  belongs_to :access_account, inverse_of: :access_account_permissions
  belongs_to :permission, inverse_of: :access_account_permissions

  validates_uniqueness_of :permission_id, scope: :access_account, message: "is assigned to this account already"
end
