class TagComment < ApplicationRecord
  #### associations ####
  belongs_to :tag_commenter, class_name: 'User'
  belongs_to :tag
end


# done associations
