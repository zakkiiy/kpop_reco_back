class Api::V1::UsersController < ApplicationController
  def create
    # 条件に該当するデータがあればそれを返す。なければ新規作成
    user = User.find_or_create_by!(provider: params[:provider], uid: params[:uid], name: params[:name], avatar_url: params[:avatar_url])
    if user
      head :ok
    else
      render json: { error: "ログインに失敗しました" }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
