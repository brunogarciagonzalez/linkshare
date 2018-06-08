class LinksController < ApplicationController
  # url: nil, active: true

  def all_links
    @links = Link.all

    render json: {status: "success", action:"all_links", links: @links}, status: 200
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

    @tag = Tag.find(tag_id_from_params)

    if @tag
      render json: {status: "success", action: "all_links_for_tag", tag: @tag, links: @tag.links}, status: 200
    else
      render json: {status: "failure", action: "all_links_for_tag", details: "tag not found (by id)"}, status: 200
    end
  end

  # def construct_link
  #   url_from_params = strong_construct_link_params[:url]
  #
  #   @link = Link.new(url: url_from_params)
  #
  #   if @link.save
  #     render json: {status: "success", action: "construct_link", link: @link}, status: 200
  #   else
  #     render json: {status: "failure", action: "construct_link", errors: @link.errors.full_messages}, status: 200
  #   end
  # end

  # def update_link
  #   link_id_from_params = strong_update_link_params[:id]
  #   new_link_content_from_params = strong_update_link_params[:url]
  #
  #   @link = Link.find(link_id_from_params)
  #
  #   if @link.update(url: new_link_content_from_params)
  #     render json: {status: "success", action: "update_link", link: @link}, status: 200
  #   else
  #     render json: {status: "failure", action: "update_link", errors: @link.errors.full_messages}, status: 200
  #   end
  # end

  # def destroy_link
  #   link_id_from_params = strong_destroy_link_params[:id]
  #   @link = Link.find(link_id_from_params)
  #
  #   if @link
  #     @link.destroy
  #       render json: {status: "success", action: "destroy_link", link: @link}, status: 200
  #   else
  #     render json: {status: "failure", action: "destroy_link", details: "link not found (by id)"}, status: 200
  #   end
  # end

  private
  #### params-related ####
  def strong_all_links_for_tag_params
    params.require(:tag).permit(:id)
  end

  def strong_get_link_params
    params.require(:link).permit(:id)
  end

  # def strong_construct_link_params
  #   params.require(:link).permit(:url)
  # end

  # def strong_update_link_params
  #   params.require(:link).permit(:id, :url)
  # end

  # def strong_destroy_link_params
  #   params.require(:link).permit(:id)
  # end
end
