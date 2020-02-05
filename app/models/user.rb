class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :invitable,
         :timeoutable, timeout_in: 30.minutes

  belongs_to :role
  has_many :approvals, foreign_key: "approver_id"
end
