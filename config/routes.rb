Rails.application.routes.draw do

  # user-related
  post '/login', to: 'users#login'
  post '/create_account', to: 'users#construct_account'

  # tag-related
  get '/tags', to: 'tags#all_tags'
  post '/tags/construct', to: 'tags#construct_tag'
  post '/tags/deactivate', to: 'tags#deactivate_tag'
end
