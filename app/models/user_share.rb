class UserShare < ApplicationRecord
  #### associations ####
  belongs_to :user
  belongs_to :link
  has_one :review

  #### validations ####
  validates :user_id, presence: true
  validates :link_id, presence: true
end

# done associations
# done validations
