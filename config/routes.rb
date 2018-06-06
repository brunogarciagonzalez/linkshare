Rails.application.routes.draw do

  # user-related
  post '/login', to: 'users#login'
  post '/create_account', to: 'users#construct_account'

  # tag-related
  get '/tags', to: 'tags#all_tags'
  post '/tags/construct', to: 'tags#construct_tag'
  post '/tags/destroy', to: 'tags#destroy_tag'
  post '/tags/update', to: 'tags#update_tag'
  post '/tags/get', to: 'tags#get_tag'
end
