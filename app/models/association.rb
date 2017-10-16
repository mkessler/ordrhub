class Association < ApplicationRecord
  belongs_to :store
  belongs_to :user

  validates :store_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :store_id }
end
