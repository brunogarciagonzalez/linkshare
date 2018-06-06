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

  def construct_tag_comment
    tag_id_from_params = strong_construct_tag_comment_params[:tag_id]
    tag_commenter_id_from_params = strong_construct_tag_comment_params[:tag_commenter_id]
    content_from_params = strong_construct_tag_comment_params[:content]

    @tag_comment = TagComment.new(tag_id: tag_id_from_params, tag_commenter_id: tag_commenter_id_from_params, content: content_from_params)

    if @tag_comment.save
      render json: {status: "success", action: "construct_tag_comment", tag_comment: @tag_comment, tag: @tag_comment.tag}
    else
      render json: {status: "failure", action: "construct_tag_comment", errors: @tag_comment.erros.full_messages}
    end
  end

  def update_tag_comment
    # update tag_comment given tag_comment.id
    tag_comment_id_from_params = strong_update_tag_comment_params[:id]

    new_tag_comment_content_from_params = strong_update_tag_comment_params[:content]

    @tag_comment = TagComment.find(tag_comment_id_from_params)

    if @tag_comment.update(content: new_tag_comment_content_from_params)
      render json: {status: "success", action:"update_tag_comment", tag: @tag_comment.tag, tag_comment: @tag_comment}, status: 200
    else
      render json: {status: "failure", action:"update_tag_comment", errors: @tag_comment.errors.full_messages}, status: 200
    end
  end

  def destroy_tag_comment
    # destroy tag_comment given tag_comment.id
    tag_comment_id_from_params = strong_destroy_tag_comment_params[:id]

    @tag_comment = TagComment.find(tag_comment_id_from_params)

    if @tag_comment

      @tag_comment.destroy
      
      render json: {status: "success", action: "destroy_tag_comment", tag: @tag_comment.tag, tag_comment: @tag_comment}, status: 200
    else
      render json: {status: "failure", action: "destroy_tag", details: "tag_comment not found (by id)"}, status: 200
    end
  end

  private
  #### params-related ####
  def strong_all_comments_for_tag_params
    params.require(:tag).permit(:id)
  end

  def strong_get_tag_comment_params
    params.require(:tag_comment).permit(:id)
  end

  def strong_construct_tag_comment_params
    params.require(:tag_comment).permit(:tag_id, :tag_commenter_id, :content)
  end

  def strong_update_tag_comment_params
    params.require(:tag_comment).permit(:id, :content)
  end

  def strong_destroy_tag_comment_params
    params.require(:tag_comment).permit(:id)
  end
end
