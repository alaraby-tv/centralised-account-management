class AccessAccount < ApplicationRecord
  before_save :find_or_create_permission
  belongs_to :approver, class_name: "User", optional: true
  has_many :access_requests
  has_many :requests, through: :access_requests
  has_and_belongs_to_many :permissions
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

  def approvable?
    self.approvable
  end
end
