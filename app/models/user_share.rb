class UserShare < ApplicationRecord
  #### associations ####
  belongs_to :user
  belongs_to :link
  has_one :review
  has_many :user_share_tag_joins
  has_many :tags, through: :user_share_tag_joins
  
  #### validations ####
  validates :user_id, presence: true
  validates :link_id, presence: true
end

# done associations
# done validations
