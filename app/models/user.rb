class User < ApplicationRecord
  #### associations ####
  has_many :review_comments, foreign_key: 'review_commenter_id'
  has_many :reviews, foreign_key: 'reviewer_id'
  has_many :tag_comments, foreign_key: 'tag_commenter_id'
  has_many :user_shares

  #### encryption ####
  has_secure_password
end

# done associations
# done password encryption
