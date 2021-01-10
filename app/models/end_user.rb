class EndUser < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((alaraby\.)+(tv))\z/i
  has_many :requests, inverse_of: :end_user
  has_many :access_requests, inverse_of: :end_user
  has_many :access_accounts, -> { distinct }, through: :access_requests

  validates_presence_of :first_name, :last_name
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX

  def name
  	"#{first_name} #{last_name}"
  end
end
