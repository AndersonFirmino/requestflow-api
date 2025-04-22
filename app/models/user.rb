class User < ApplicationRecord
  has_secure_password

  has_many :requests, dependent: :destroy

  enum role: { user: "user", admin: "admin" }

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: roles.keys }
end
