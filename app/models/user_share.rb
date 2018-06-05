class UserShare < ApplicationRecord
  belongs_to :user
  belongs_to :link
  has_one :review
end
# done associations
