class ReviewComment < ApplicationRecord
  #### associations ####
  belongs_to :review_commenter, class_name: 'User'
  belongs_to :review

  #### validations ####
  validates :review_id, presence: true
  validates :review_commenter_id, presence: true
  validates :content, presence: true

end

# done associations
