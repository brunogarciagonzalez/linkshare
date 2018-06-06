class TagsController < ApplicationController
  def all_tags
    # return all tags, sorted alphabetically
    @tags = Tag.order('title ASC')

    render json: {tags: @tags}, status: 200
  end

  def construct_tag
    # add new tag (formatted) to database if it is validated
    # return json with status and either new tag || errors array
    title_from_params = strong_construct_tag_params[:title]

    @tag = Tag.new(title: format_title(title_from_params))

    if @tag.save
      render json: {status: "success", 'tag_added': @tag}
    else
      render json: {status: "failure", errors: @tag.errors.full_messages}
    end
  end

  def deactivate_tag
    tag_id_from_params = strong_deactivate_tag_params[:tag_id]
    byebug
    # what happens to the links associated with the tag
    # if the links only have this one tag?
      # they get destroyed as well


    # destruction vs deactivation
  end

  def update_tag
    # need route
  end

  private
  def strong_construct_tag_params
    params.require(:tag).permit(:title)
  end

  def strong_deactivate_tag_params
    params.require(:tag).permit(:tag_id)
  end

  def format_title(title)
    title.gsub(/\w+/) do |word|
      word.capitalize
    end
  end
end
