require 'google/apis/youtube_v3'

class Api::V1::YoutubeVideoApiTestsController < ApplicationController
  def latest_videos
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = ENV['YOUTUBE_API_KEY']

    channel_id = 'UC9GtSLeksfK4yuJ_g1lgQbg'

    begin
      response = service.list_searches('snippet', channel_id: channel_id, order: 'date', type: 'video', max_results: 10)
      videos = response.items.map do |item|
        {
          video_id: item.id.video_id,
          title: item.snippet.title,
          description: item.snippet.description,
          published_at: item.snippet.published_at,
          thumbnail_url: item.snippet.thumbnails.default.url
        }
      end

      render json: { videos: videos }
    rescue Google::Apis::ClientError => e
      render json: { error: e.message }, status: :bad_request
    end
  end
end
