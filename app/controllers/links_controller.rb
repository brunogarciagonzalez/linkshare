class LinksController < ApplicationController
  # url: nil, active: true

  def all_links
    @links = Link.all

    render json: {status: "success", action:"all_links", links: @links}, status: 200
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

  def get_link

  end

  def construct_link

  end

  def update_link

  end

  def destroy_link
  end

  private
  #### params-related ####
  def strong_all_links_for_tag_params
    params.require(:tag).permit(:id)
  end

end
