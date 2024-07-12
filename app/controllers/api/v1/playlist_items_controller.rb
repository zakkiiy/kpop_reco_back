class Api::V1::PlaylistItemsController < ApplicationController
  before_action :set_current_user
  before_action :set_playlist

  def index
    playlist_items = @playlist.playlist_items.includes(:kpop_video)
    render json: {
      playlist_id: @playlist.id,
      playlist_name: @playlist.name,
      items: playlist_items.as_json(include: { kpop_video: { only: [:id, :name] } })
    }, status: :ok
  end
  
  def create
    playlist_item = @playlist.playlist_items.build(kpop_video_id: params[:kpop_video_id])

    if playlist_item.save
      render json: { message: 'Playlist item created successfully' }, status: :created
    else
      render json: { error: 'プレイリストアイテムの作成に失敗しました' }, status: :unprocessable_entity
    end
  end

  def destroy
    playlist_item = @playlist.playlist_items.find_by(kpop_video_id: params[:id])
    if playlist_item
      playlist_item.destroy
      head :no_content
    else
      render json: { error: 'プレイリストアイテムが見つかりません' }, status: :not_found
    end
  end

  private

  def set_playlist
    @playlist = @current_user.playlists.find(params[:playlist_id])
  end
end
