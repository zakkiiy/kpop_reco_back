Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/:provider/callback", to: "api/v1/users#create"
      get 'youtube_video_api_tests/latest', to: 'youtube_video_api_tests#latest_videos'
    end
  end
end
