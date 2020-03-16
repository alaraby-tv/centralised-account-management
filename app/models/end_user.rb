class EndUser < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((alaraby\.)+(tv))\z/i
  has_many :requests
  has_many :access_requests, through: :requests

  validates_presence_of :first_name, :last_name
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX

  def name
  	"#{first_name} #{last_name}"
  end
end
