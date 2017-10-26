class Source < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  def self.grubhub
    find_by_name('GrubHub')
  end
end
