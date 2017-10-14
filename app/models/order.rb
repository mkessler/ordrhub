class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :source

  validates :restaurant_id, :source_id, presence: true
end
