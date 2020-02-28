class AccessRequest < ApplicationRecord
  belongs_to :access_account
  belongs_to :request
end
