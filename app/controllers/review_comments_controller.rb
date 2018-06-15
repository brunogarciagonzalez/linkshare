class ReviewCommentsController < ApplicationController
  # review_id: nil, review_commenter_id: nil, content: nil
  skip_before_action :authorized, only: [:all_comments_for_review, :get_review_comment]

  def all_comments_for_review
    ## expected params ####
    # review: {
        # :id
    # }

    # get review by id
    review_id_from_params = strong_all_comments_for_review_params[:id]
    @review = Review.find(review_id_from_params)
    #if not then render
    if !@review
      render json: {status: "failure", action: "all_comments_for_review", details: "review not found (by id)"}, status: 200
      return
    end

    # produce serialized_review_comments
    serialized_review_comments = []
    @review.review_comments.each do |r_c|
      serialized_review_comments.push(r_c)
    end

    #render
    render json: {status: "success", action: "all_comments_for_review",
      review: @review, review_comments: serialized_review_comments}, status: 200

  end

  def get_review_comment
    ## expected params ####
    # review_comment: {
        # :id
    # }

    # get review_comment by id
    review_comment_id_from_params = strong_get_review_comment_params[:id]
    @review_comment = ReviewComment.find(review_comment_id_from_params)

    # if not then render
    if !@review_comment
      render json: {status: "failure", action: "get_review_comment", details: "review_comment not found (by id)"}, status: 200
      return
    end

    # want user of review_comment, and all review_comment
    serialized_review_comment = {
      review_comment: @review_comment,
      review_commenter: @review_comment.review_commenter
    }
    # want review and reviewer
    serialized_review = {reviewer: @review_comment.review.reviewer, review: @review_comment.review}


    # render
    render json: {status: "success", action: "all_comments_for_review",
      review_comment_information: serialized_review_comment, review_information: serialized_review}, status: 200
  end

  private
  #### params-related ####
  def strong_all_comments_for_review_params
    params.require(:review).permit(:id)
  end

  def strong_get_review_comment_params
    params.require(:review_comment).permit(:id)
  end
end
