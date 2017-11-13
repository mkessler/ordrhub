class Order < ApplicationRecord
  belongs_to :store
  belongs_to :source

  validates :store_id, :source_id, presence: true
  validates :number, presence: true, uniqueness: { scope: [:store_id, :source_id] }

  default_scope { order(created_at: :desc) }

  include PgSearch
  pg_search_scope :search,
                  against: [:name, :number, :phone_number],
                  using: {
                    tsearch: { dictionary: 'english'}
                  }
end
