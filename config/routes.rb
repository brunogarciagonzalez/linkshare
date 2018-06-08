Rails.application.routes.draw do

  #### user-related ####
  post '/users/login', to: 'users#login'
  post '/users/construct', to: 'users#construct_account'
  post '/users/update', to: 'users#update_account'
  post '/users/destroy', to: 'users#destroy_account'
  post '/users/get', to: 'users#get_account'
  post '/users/deactivate', to: 'users#deactivate_account'

  #### user_share-related ####
  post '/user-shares/construct', to: 'user_shares#construct_user_share'
  post '/user-shares/destroy', to: 'user_shares#destroy_user_share'
  post '/user-shares/update', to: 'user_shares#update_user_share'

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

  #### link-related ####
  get "/links", to: 'links#all_links'
  post "/links/for_tag", to: 'links#all_links_for_tag'
  post "/links/get", to: 'links#get_link'
  # post "/links/construct", to: 'links#construct_link'
  # post "/links/update", to: 'links#update_link'
  # post "/links/destroy", to: 'links#destroy_link'

  #### link_tag_join -related ####
  post "/link-tag-joins/construct", to: 'link_tag_joins#construct_link_tag_join'
  post "/link-tag-joins/destroy", to: 'link_tag_joins#destroy_link_tag_join'

end
