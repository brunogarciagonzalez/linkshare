Rails.application.routes.draw do

  #### user-related ####
  post '/users/sign_in', to: 'users#sign_in'
  post '/users/construct', to: 'users#construct_account'
  post '/users/update', to: 'users#update_account'
  post '/users/destroy', to: 'users#destroy_account'
  post '/users/get', to: 'users#get_account'
  post '/users/deactivate', to: 'users#deactivate_account'

  #### user_share-related ####
  post '/user-shares/get', to: 'user_shares#get_user_share'
  post '/user-shares/for_link', to: 'user_shares#all_user_shares_for_link'
  post '/user-shares/construct', to: 'user_shares#construct_user_share'
  post '/user-shares/destroy', to: 'user_shares#destroy_user_share'
  post '/user-shares/update', to: 'user_shares#update_user_share'

  #### link-related ####
  get "/links", to: 'links#all_links'
  post "/links/for_tag", to: 'links#all_links_for_tag'
  post "/links/get", to: 'links#get_link'

  #### tag-related ####
  get '/tags', to: 'tags#all_tags'
  post '/tags/get', to: 'tags#get_tag'
  post '/tags/construct', to: 'tags#construct_tag'
  post '/tags/update', to: 'tags#update_tag'
  post '/tags/destroy', to: 'tags#destroy_tag'

  #### tag_comment-related ####
  post "/tag-comments/for_tag", to: 'tag_comments#all_comments_for_tag'
  post "/tag-comments/get", to: 'tag_comments#get_tag_comment'
  post "/tag-comments/construct", to: 'tag_comments#construct_tag_comment'
  post "/tag-comments/update", to: 'tag_comments#update_tag_comment'
  post "/tag-comments/destroy", to: 'tag_comments#destroy_tag_comment'

  #### review_comment-related ####
  post "/review-comments/get", to: 'review_comments#get_review_comment'
  post "/review-comments/for_review", to: 'review_comments#all_comments_for_review'
  post "/review-comments/construct", to: 'review_comments#construct_review_comment'

end
