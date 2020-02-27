class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :invitable,
         :timeoutable, timeout_in: 30.minutes

  belongs_to :role
  has_many :approvals, foreign_key: "approver_id"
  has_many :requests, foreign_key: "requester_id"
  has_many :access_requests, through: :requests

  def name
    "#{first_name} #{last_name}"
  end
end
