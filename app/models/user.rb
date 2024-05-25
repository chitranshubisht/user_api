class User < ApplicationRecord
  has_secure_password
  has_many :posts
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def self.ransackable_attributes(_auth_object = nil)
    %w[address created_at email gender id id_value name password_digest pincode updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['posts']
  end
end
