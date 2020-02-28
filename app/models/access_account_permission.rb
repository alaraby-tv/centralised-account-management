class AccessAccountPermission < ApplicationRecord
  belongs_to :access_account
  belongs_to :permission
end
