class User < ApplicationRecord
  #### associations ####
  has_many :review_comments, foreign_key: 'review_commenter_id'
  has_many :reviews, foreign_key: 'reviewer_id'
  has_many :tag_comments, foreign_key: 'tag_commenter_id'
  has_many :user_shares

  #### encryption ####
  has_secure_password

  #### validations ####
  # username
  validates :username, uniqueness: {case_sensitive: false}
  validates :username, presence: true
  validates :username, format: { without: /\s/ }

  # email
  validates :email, uniqueness: {case_sensitive: false}
  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  # password
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password,
    presence: true,
    length: { minimum: 8 },
    format: { with: PASSWORD_FORMAT }

end

# done associations
# done password encryption
# done validations
