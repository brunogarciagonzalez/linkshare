class LinkTagJoinsController < ApplicationController
  def construct_link_tag_join
    link_id_from_params = strong_construct_link_tag_join_params[:link_id]
    tag_id_from_params = strong_construct_link_tag_join_params[:tag_id]

    @link_tag_join = LinkTagJoin.new(link_id: link_id_from_params, tag_id: tag_id_from_params)

    if @link_tag_join.save
      render json: {status: "success", action: "construct_link_tag_join", link: @link_tag_join}, status: 200
    else
      render json: {status: "failure", action: "construct_link_tag_join", errors: @link_tag_join.errors.full_messages}, status: 200
    end
  end

  private
  #### params-related ####
  def strong_construct_link_tag_join_params
    params.require(:link_tag_join).permit(:link_id, :tag_id)
  end
end
