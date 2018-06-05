class ReviewComment < ApplicationRecord
  #### associations ####
  belongs_to :review_commenter, class_name: 'User'
  belongs_to :review
end

# done associations
