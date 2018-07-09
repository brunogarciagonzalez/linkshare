class Review < ApplicationRecord
  #### associations ####
  belongs_to :reviewer, class_name: 'User'
  has_many :review_comments
  has_one :user_share
  has_many :votes

  #### validations ####
  validates :reviewer_id, presence: true
  validates :content, presence: true
  validates :content, length: { minimum: 240 }
  validates :rating, presence: true
  validates :rating, numericality: { less_than_or_equal_to: 10,  only_integer: true }
  validates :rating, numericality: { more_than_or_equal_to: 1,  only_integer: true }

end

# done associations
# done validations
