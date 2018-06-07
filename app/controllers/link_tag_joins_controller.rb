class LinkTagJoinsController < ApplicationController
  def construct_link_tag_join
    link_id_from_params = strong_construct_link_tag_join_params[:link_id]
    tag_id_from_params = strong_construct_link_tag_join_params[:tag_id]

    @link_tag_join = LinkTagJoin.new(link_id: link_id_from_params, tag_id: tag_id_from_params)

    if @link_tag_join.save
      render json: {status: "success", action: "construct_link_tag_join", link_tag_join: @link_tag_join}, status: 200
    else
      render json: {status: "failure", action: "construct_link_tag_join", errors: @link_tag_join.errors.full_messages}, status: 200
    end
  end

  def destroy_link_tag_join
    link_tag_join_id_from_params = strong_destroy_link_tag_join_params[:id]
    @link_tag_join = LinkTagJoin.find(link_tag_join_id_from_params)

    if @link_tag_join
      @link_tag_join.destroy
      render json: {status: "success", action: "destroy_link_tag_join", link_tag_join: @link_tag_join}, status: 200
    else
        render json: {status: "failure", action: "destroy_link_tag_join", details: "link_tag_join not found (by id)"}, status: 200
    end
  end

  private
  #### params-related ####
  def strong_construct_link_tag_join_params
    params.require(:link_tag_join).permit(:link_id, :tag_id)
  end

  def strong_destroy_link_tag_join_params
    params.require(:link_tag_join).permit(:id)
  end
end
