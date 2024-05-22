class Api::V1::KpopVideosController < ApplicationController
  def create_videos
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = ENV['YOUTUBE_API_KEY']

    artists = Artist.all
    channel_ids = artists.map(&:channel_id)
    p channel_ids

    video_lists = []

    channel_ids.each do |channel_id|
      begin
        response = service.list_searches('snippet', channel_id: channel_id, order: 'date', type: 'video', max_results: 10)
        
        File.open("response_#{channel_id}.json", "w") do |file|
          file.write(JSON.pretty_generate(response.to_h))
        end

        video_ids = response.items.map { |item| item.id.video_id }

        video_details_response = service.list_videos('snippet,statistics', id: video_ids.join(','))

        video_details_response.items.each do |video_item|
          artist = Artist.find_by(channel_id: channel_id)
          if artist
            video = KpopVideo.create(
              video_id: video_item.id,
              name: video_item.snippet.title,
              image: video_item.snippet.thumbnails.default.url,
              view_count: video_item.statistics.view_count,
              posted_at: video_item.snippet.published_at,
              artist_id: artist.id
            )
            video_lists << video
          end
        end
      rescue Google::Apis::ClientError => e
        Rails.logger.error("Error fetching videos for channel #{channel_id}: #{e.message}")
      end
    end

    render json: { videos: video_lists }
  end
end