class LinkTagJoin < ApplicationRecord
  #### associations ####
  belongs_to :link
  belongs_to :tag
end

# done associations
