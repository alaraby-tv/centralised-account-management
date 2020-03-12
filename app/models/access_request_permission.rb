class AccessRequestPermission < ApplicationRecord
  belongs_to :access_request, optional: true
  belongs_to :permission, optional: true
end
