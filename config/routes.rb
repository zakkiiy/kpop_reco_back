Rails.application.routes.draw do
  post "auth/:provider/callback", to: "api/v1/users#create"
  namespace :api do
    namespace :v1 do
      get 'youtube_video_api_tests/latest', to: 'youtube_video_api_tests#latest_videos'
      post 'kpop_videos/create_videos', to: 'kpop_videos#create_videos' 
    end
  end
end
