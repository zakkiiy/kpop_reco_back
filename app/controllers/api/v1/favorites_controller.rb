class Api::V1::FavoritesController < ApplicationController
  before_action :set_current_user

  def create
    begin
      video = KpopVideo.find(params[:video_id])
      favorite = @current_user.favorites.build(kpop_video: video)
      
      if favorite.save
        render json: { success: true, favorite: favorite }, status: :created
      else
        render json: { success: false, errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
    rescue => e
      render json: { success: false, errors: e.message }, status: :internal_server_error
    end
  end

  def destroy
    video = KpopVideo.find(params[:video_id])
    favorite = @current_user.favorites.find_by(kpop_video_id: video)
    if favorite
      favorite.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false, errors: ['Favorite not found'] }, status: :not_found
    end
  end

  def check
    video = KpopVideo.find(params[:id])
    favorite = @current_user.favorites.find_by(kpop_video_id: video)
    render json: { isFavorite: favorite.present? }
  end

  private

  def favorite_params
    params.require(:favorite).permit(:kpop_video_id)
  end
end
