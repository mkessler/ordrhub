class Store < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations
  has_many :orders, dependent: :destroy

  validates :name, presence: true

  def users_count
    if organization_id?
      organization.users.count + users.count
    else
      users.count
    end
  end
end
