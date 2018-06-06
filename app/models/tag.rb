class Tag < ApplicationRecord
  #### associations ####
  has_many :tag_comments
  has_many :link_tag_joins
  has_many :links, through: :link_tag_joins

  #### associations ####
  validates :title, presence: true
  validates :title, uniqueness: true
end

# done associations
# done validations
