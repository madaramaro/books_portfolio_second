class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posted_favorite_lists = @user.favorite_lists
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def follow
    @user = User.find(params[:id])
    
    if current_user.follow(@user)
      # フォロー成功時のリダイレクト先を変更
      redirect_to posts_path, notice: "#{@user.name}をフォローしました。"
    else
      # フォロー失敗時のリダイレクト先も変更
      redirect_to posts_path, alert: '自分自身をフォローすることはできません'
    end
    
  end
  
  def unfollow
    @user = User.find(params[:id])
    
    current_user.unfollow(@user)
    # フォロー解除後のリダイレクト先を変更
    redirect_to posts_path, notice: "#{@user.name}のフォローを解除しました。"
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following
    # ここにページのロジックを実装
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    # ここにページのロジックを実装
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

end
