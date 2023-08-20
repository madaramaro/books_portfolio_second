class PostsController < ApplicationController
    def index
      @posted_favorite_lists = FavoriteList.includes(:user).where(posted: true)

        # 検索クエリが存在する場合
      if params[:search].present?
        @posted_favorite_lists = @posted_favorite_lists.where("name LIKE ?", "%#{params[:search]}%")
      end
    end
  end
  