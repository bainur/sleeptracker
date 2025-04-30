# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/clock_in', to: 'sleep_records#clock_in'
      post '/clock_out', to: 'sleep_records#clock_out'
      get '/sleep_records', to: 'sleep_records#index'
      get '/friends_sleep_records', to: 'sleep_records#friends_sleep_records'

      get '/profile', to: 'users#profile'
      post '/follow', to: 'users#follow'
      delete '/unfollow', to: 'users#unfollow'
    end
  end
end
