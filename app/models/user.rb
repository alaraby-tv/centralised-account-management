class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :invitable,
         :timeoutable, timeout_in: 30.minutes

  belongs_to :role, inverse_of: :users
  has_many :access_accounts, foreign_key: "approver_id", inverse_of: :approver
  has_many :requests, foreign_key: "requester_id", inverse_of: :requester
  has_many :access_requests, through: :requests

  delegate :name, to: :role, prefix: true
  
  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    role_name == 'admin'
  end

  def support_member?
    role_name == 'broadcast engineer' or role_name == 'IT engineer'
  end
end
