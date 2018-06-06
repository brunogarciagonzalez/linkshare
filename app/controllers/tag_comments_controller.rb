class TagCommentsController < ApplicationController
  # tag_id: nil, tag_commenter_id: nil, content: nil

  def all_comments_for_tag
    tag_id_from_params = strong_all_comments_for_tag_params[:id]
    @tag = Tag.find(tag_id_from_params)

    if @tag
      render json: {status: "success", action: "all_comments_for_tag", tag_comments: @tag.tag_comments, tag: @tag}, status: 200
    else
      render json: {status: "failure", action: "all_comments_for_tag", details: "tag not found (by id)"}, status: 200
    end
  end

  def get_tag_comment
    comment_id_from_params = strong_get_tag_comment_params[:id]
    @tag_comment = TagComment.find(comment_id_from_params)

    if @tag_comment
      render json: {status: "success", action: "get_tag_comment", tag_comment: @tag_comment, tag: @tag_comment.tag}, status: 200
    else
      render json: {status: "failure", action: "get_tag_comment", details: "tag_comment not found (by id)"}, status: 200
    end
  end

  def construct_comment
  end

  def update_comment
  end

  def destroy_comment
  end

  private
  #### params-related ####
  def strong_all_comments_for_tag_params
    params.require(:tag).permit(:id)
  end

  def strong_get_tag_comment_params
    params.require(:tag_comment).permit(:id)
  end
end
