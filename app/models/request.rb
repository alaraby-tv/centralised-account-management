class Request < ApplicationRecord
  belongs_to :end_user
  belongs_to :requester
  belongs_to :access_account
  belongs_to :permission
end
