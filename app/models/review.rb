class Review < ApplicationRecord
  #### associations ####
  belongs_to :reviewer, class_name: 'User'
  has_many :review_comments
  has_one :user_share
end

# done associations
