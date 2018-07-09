class VotesController < ApplicationController
  # review_id: nil, review_commenter_id: nil, content: nil
  skip_before_action :authorized

  def get_vote
    ## expected params ####
    # review: {
        # :review_id,
        # :token
    # }

    # if token nil current_user is not logged in. This means that they should see "helpful?" and should be directed to login upon clicking
    review_id_from_params = strong_get_vote_params[:review_id]
    token_from_params = strong_get_vote_params[:token]

    @review = Review.find(review_id_from_params)

    if token_from_params
      # get user id from token
      current_user_id = get_user_id_from_token(token_from_params)

      # did the current user vote for this review?
      current_user_voted = false

      # is current user the author of the review?
      review_is_by_current_user = false

      if @review.reviewer.id == current_user_id
        review_is_by_current_user = true
      end

      # count number of helpful
      num_helpful = 0

      @review.votes.each do |vote|
        if vote.helpful
          num_helpful += 1
        end
        if vote.user_id == current_user_id
          current_user_voted = true
        end
      end
      render json: {status: "success", action: "get_vote", helpful_votes: num_helpful, current_user_voted: current_user_voted, review_is_by_current_user: review_is_by_current_user}, status: 200
    else

      # count number of helpful
      num_helpful = 0

      @review.votes.each do |vote|
        if vote.helpful
          num_helpful += 1
        end
      end
      render json: {status: "success", action: "get_vote", helpful_votes: num_helpful, current_user_voted: false, review_is_by_current_user: false }, status: 200
    end


    # need to return number of helful, funny, and if current_user has already voted
  end

  def construct_vote
    ## expected params ####
    # review: {
        # :review_id,
        # :token
    # }

    # token is present (fetch only occurs if user logged in)
    review_id_from_params = strong_construct_vote_params[:review_id]
    token_from_params = strong_construct_vote_params[:token]
    current_user_id = get_user_id_from_token(token_from_params)
    helpful_boolean = strong_construct_vote_params[:helpful_boolean]


    @vote = Vote.create(review_id: review_id_from_params, user_id: current_user_id, helpful: helpful_boolean)

    render json: {status: "success", action: "construct_vote", vote: @vote}, status: 200

  end

  private
  #### params-related ####
  def strong_get_vote_params
    params.require(:review).permit(:review_id, :token)
  end

  def strong_construct_vote_params
    params.require(:review).permit(:review_id, :token, :helpful_boolean)
  end

  #### helper functions ####
  def get_user_id_from_token(token)
    secret = "secret"
    # decode payload: [{user_id: user.id}, {alg...}]
    payload = JWT.decode(token,secret, "HS256")
    # find user
    payload[0]["user_id"]
  end
end
