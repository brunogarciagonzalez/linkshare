class UserShareTagJoin < ApplicationRecord
  #### associations ####
  belongs_to :user_share
  belongs_to :tag
end
