class UserShare < ApplicationRecord
  #### associations ####
  belongs_to :user
  belongs_to :link
  has_one :review
  has_many :user_share_tag_joins
  has_many :tags, through: :user_share_tag_joins
  
  #### validations ####
  validates :user_id, presence: true
  validates :link_id, presence: true


  # for seeding purposes

  def self.construct(tags:, link_url:, review_information:, user_id:)
    ## expected arguments ####
    # {
        # :user_id,
        # :review_information => {:content, :rating},
        # :link_url,
        # :tags[]
    # }

   
    ## review-related ##
    review_content = review_information[:content]
    review_rating = review_information[:rating]


    #########################################

    # have to produce X.new & instance.valid? for every one of the models to be made,
    # so that all logic happens together if correct
    # or no logic happens at all if any error
     # if all of them are valid move forward,
     # else send back a detailed errors list for use in updating form

    if !user_id.is_a?(Integer)
      raise ArgumentError, 'user_id is not an integer'
    end 

     if !(link_url.include?("http"))
       link_url = "https://" + link_url
     else
       if !(link_url.include?("https"))
         # split it at "//"
         b = link_url.split("://")[1]
         link_url = "https://" + b
       end
     end

     if link_url.include?("www.")
       link_url = link_url.split("www.").join("")
     end

    temp_link = Link.new(url: link_url)
    temp_review = Review.new(reviewer_id: user_id, content: review_content, rating: review_rating)

    # load the instances up with errors (if any).
    # since the following if statement may not populate all errors due to nature of an || statement

    temp_link.valid?
    temp_review.valid?

    if !temp_link.valid? ||
      tags.length == 0 ||
      !temp_review.valid?
      return {status: "failure", action: "construct_user_share", link_errors: temp_link.errors.full_messages, review_errors: temp_review.errors.full_messages, tags_length: tags.length}
    end

    #########################################


    # if link not in database, persist the link in the database
    @link = Link.find_or_create_by(url: link_url)

    # persist link-tag-joins in the database
    # only if link_tag_join doesn't already exists
    tags.each do |tag|
      @tag = Tag.find_by(title: tag)

      if !LinkTagJoin.find_by(link_id: @link.id, tag_id: @tag.id)
        LinkTagJoin.create(tag_id: @tag.id, link_id: @link.id)
      end
    end

    # persist the review in the database
    @review = Review.create(reviewer_id: user_id, link_id: @link.id, content: review_content, rating: review_rating)

    # persist the use-share in the database
    @user_share = UserShare.create(user_id: user_id, link_id: @link.id, review_id: @review.id)

    # update review and any others with user-share
    @review.user_share_id = @user_share.id
    @review.save

    tags.each do |tag|
      @tag = Tag.find_by(title: tag)

      UserShareTagJoin.create(tag_id: @tag.id, user_share_id: @user_share.id)
    end

    puts @user_share
    return @user_share
  end

end

# done associations
# done validations
