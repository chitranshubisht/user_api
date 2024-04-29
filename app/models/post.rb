class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id id_value title updated_at user_id]
  end
end
