class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :source

  validates :restaurant_id, :source_id, presence: true

  def items
    if self.details['items']
      JSON.parse(self.details['items'])
    else
      []
    end
  end
end
