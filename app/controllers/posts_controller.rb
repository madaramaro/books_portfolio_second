class PostsController < ApplicationController
  def index
    @posted_favorite_lists = FavoriteList.includes(:user).where(posted: true)

    # キーワードによる検索が存在する場合
    if params[:search].present?
      @posted_favorite_lists = @posted_favorite_lists.where("name LIKE ?", "%#{params[:search]}%")
    end

    # ユーザーによる絞り込みが存在する場合
    if params[:user_id].present?
      @posted_favorite_lists = @posted_favorite_lists.where(user_id: params[:user_id])
    end
  end

  def show
    @favorite_list = FavoriteList.find(params[:id])
  end
end
