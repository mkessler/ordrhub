class Restaurant < ApplicationRecord
  belongs_to :organization, optional: true
end
