class AccessAccount < ApplicationRecord
  belongs_to :approver, class_name: "User"
end
