class Link < ApplicationRecord
  #### associations ####
  has_many :reviews
  has_many :user_shares
  has_many :link_tag_joins
  has_many :tags, through: :link_tag_joins
  has_many :user_shares
end

# done associations
