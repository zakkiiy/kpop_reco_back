Rails.application.routes.draw do
  post "auth/:provider/callback", to: "api/v1/users#create"
  namespace :api do
    namespace :v1 do
      resources :kpop_videos
      get 'youtube_video_api_tests/latest', to: 'youtube_video_api_tests#latest_videos'
      post 'kpop_videos/create_videos', to: 'kpop_videos#create_videos' 
      resources :videos, only: [] do
        resource :favorite, only: [:create, :destroy]
        member do
          get 'check', to: 'favorites#check'
        end
      end
      resources :favorites, only: [:index]
      resources :playlists, only: [:index, :create]
    end
  end
end
