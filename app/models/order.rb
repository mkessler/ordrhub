class Order < ApplicationRecord
  belongs_to :store
  belongs_to :source

  validates :store_id, :source_id, presence: true

  default_scope { order(created_at: :desc) }

  include PgSearch
  multisearchable :against => [:name, :number, :phone_number]
end
