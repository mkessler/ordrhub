class Restaurant < ApplicationRecord
  belongs_to :organization

  validates :organization_id, :name, presence: true
end
