class Api::V1::PlaylistsController < ApplicationController
  before_action :set_current_user

  def create
    playlist = @current_user.playlists.new(playlist_params)

    if playlist.save
      render json: playlist, status: :created
    else
      render json: { errors: playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
