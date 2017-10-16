class Order < ApplicationRecord
  belongs_to :store
  belongs_to :source

  validates :store_id, :source_id, presence: true

  def items
    if self.details['items']
      JSON.parse(self.details['items'])
    else
      []
    end
  end
end
