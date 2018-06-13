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
      render json: {status: "success", action: "get_link", link: @link}, status: 200
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
        sum = 0;
        link.reviews.each do |review|
          sum += review.rating
        end

        avg_rating = (sum / link.reviews.length.to_f).round(1)
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

end
