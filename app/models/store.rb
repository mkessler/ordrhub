class Store < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations

  validates :name, presence: true
end
