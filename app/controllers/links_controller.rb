class LinksController < ApplicationController
  # url: nil, active: true

  def all_links
    @links = Link.all

    serialized_links = []

    @links.each do |l|
      to_go = {link: l, tags: []}
      l.tags.each do |tag|
        to_go[:tags].push(tag)
      end
      serialized_links.push(to_go)
    end

    render json: {status: "success", action:"all_links", links: serialized_links}, status: 200
  end

  def get_link
    link_id_from_params = strong_get_link_params[:id]

    @link = Link.find(link_id_from_params)

    if @link
    # serialize reviews
    serialized_link_reviews = []

    @link.reviews.each do |review|
      user_share_tags = []
      review.user_share.tags.each do |u_s_tag|
        user_share_tags << {title: u_s_tag.title, id: u_s_tag.id}
      end

      serialized_review_comments = []
      review.review_comments.each do |r_c|
        serialized_review_comments << {
          review_commenter: {id: r_c.review_commenter.id, username: r_c.review_commenter.username},
          updated_at: r_c.updated_at,
          content: r_c.content
        }
      end

      reviewer = {username: review.reviewer.username, id:review.reviewer.id}
      to_go_review = {id: review.id, rating: review.rating, content: review.content, updated_at: review.updated_at}

      serialized_link_reviews << {review: review, reviewer: reviewer, user_share_tags: user_share_tags, review_comments: serialized_review_comments}
    end

    serialized_link = {id: @link.id, url: @link.url, avg_rating: get_average_rating(@link), num_reviews: @link.reviews.length}

      render json: {status: "success", action: "get_link", link: serialized_link, link_reviews: serialized_link_reviews}, status: 200
    else
      render json: {status: "failure", action: "get_link", details: "link not found (by id)"}, status: 200
    end
  end

  def all_links_for_tag
    tag_id_from_params = strong_all_links_for_tag_params[:id]

    @tag = Tag.find_by(id: tag_id_from_params)

    if @tag
    # compute link avg-rating for each
      # keep this in a variable
    # sort links by rating
    # serialize output as [...{link: link_obj, avg_rating: X}]
    # add search bar in front end just because

      serialized_links = []
      @tag.links.each do |link|
        avg_rating = get_average_rating(link)
        serialized_links << {link: link, avg_rating: avg_rating, num_reviews: link.reviews.length}
      end

      # sort by rating
      sorted_serialized_links = serialized_links.sort { |x,y| y[:avg_rating] <=> x[:avg_rating]}


      render json: {status: "success", action: "all_links_for_tag", tag: @tag, links: sorted_serialized_links}, status: 200
    else
      render json: {status: "failure", action: "all_links_for_tag", details: "tag not found (by id)"}, status: 200
    end
  end

  private
  #### params-related ####
  def strong_all_links_for_tag_params
    params.require(:tag).permit(:id)
  end

  def strong_get_link_params
    params.require(:link).permit(:id)
  end

  #### helper functions ####
  def get_average_rating(link)
    sum = 0
    link.reviews.each do |review|
      sum += review.rating
    end

    return (sum / link.reviews.length.to_f).round(1)
  end

end
