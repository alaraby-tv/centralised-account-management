class Request < ApplicationRecord
  belongs_to :end_user, inverse_of: :requests
  belongs_to :requester, class_name: 'User', inverse_of: :requests
  has_many :request_events, inverse_of: :request
  has_many :access_requests, dependent: :destroy, inverse_of: :request
  has_many :access_accounts, through: :access_requests
  accepts_nested_attributes_for :access_requests,
                                allow_destroy: true,
                                reject_if: :all_blank
  delegate :name, to: :end_user, prefix: true, allow_nil: true
  delegate :name, to: :requester, prefix: true, allow_nil: true

  validates :access_requests, presence: true, on: :update

  def label_class
    status == "submitted" ? 'primary' : 'info'
  end

  def self.drafts
    where(status: 'draft')
  end

  def self.submitted
    where(status: "submitted")
  end

  def draft?
    status == "draft"
  end

  def submitted?
    status == "submitted"
  end
end
