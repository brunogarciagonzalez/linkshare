class TagComment < ApplicationRecord
  #### associations ####
  belongs_to :tag_commenter, class_name: 'User'
  belongs_to :tag

  #### validations ####
  validates :tag_id, presence: true
  validates :tag_commenter_id, presence: true
  validates :content, presence: true
end


# done associations
# done validations
