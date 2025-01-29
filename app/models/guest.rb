class Guest < ApplicationRecord
  validates :email, format: { with: /\A[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/i },
                    uniqueness: true

  has_many :reservations
end
