class Request < ApplicationRecord
  belongs_to :user

  enum status: { pending: "pending", approved: "approved", rejected: "rejected" }

  validates :title, :description, :status, presence: true
end
