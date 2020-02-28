class AccessRequestPermission < ApplicationRecord
  belongs_to :access_request
  belongs_to :permission
end
