class AccessAccount < ApplicationRecord
  before_save :find_or_create_permission
  belongs_to :approver, class_name: "User", inverse_of: :access_accounts, optional: true
  has_many :access_requests, dependent: :destroy, inverse_of: :access_account
  has_many :requests, through: :access_requests
  has_many :end_users, -> { distinct }, through: :access_requests
  has_many :access_account_permissions, inverse_of: :access_account
  has_many :permissions, -> { distinct }, through: :access_account_permissions
  accepts_nested_attributes_for :permissions,
                                allow_destroy: true,
                                reject_if: proc { |att| att['name'].blank? }


  validates :name, presence: true
  validates_presence_of :approver, if: :approvable 

  private

  def find_or_create_permission
    self.permissions = self.permissions.map do |permission|
      Permission.find_or_create_by(name: permission.name)
    end
  end
end
