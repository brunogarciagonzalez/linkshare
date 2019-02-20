class Tag < ApplicationRecord
  #### associations ####
  has_many :tag_comments
  has_many :link_tag_joins
  has_many :links, through: :link_tag_joins
  has_many :user_share_tag_joins
  has_many :user_shares, through: :user_share_tag_joins

  #### associations ####
  validates :title, presence: true
  validates :title, uniqueness: true


  # for seeding purposes
  def self.random_group_of_x(x) 
    # return an array of length 1..x tags,  
    output = []
    x.times do 
      output << self.all.sample.title
    end

    output
  end
end

# done associations
# done validations
