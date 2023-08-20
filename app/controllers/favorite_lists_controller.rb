class FavoriteListsController < ApplicationController

  def new
    @favorite_list = FavoriteList.new
    @books = Book.all
  end

  def create
    @favorite_list = current_user.favorite_lists.build(favorite_list_params)
    if @favorite_list.save
      redirect_to @favorite_list
    else 
      @books = Book.all
      flash[:alert] = @favorite_list.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
    @favorite_list = FavoriteList.find(params[:id])
    @books = @favorite_list.books

    respond_to do |format|
      format.html
      format.json { render json: @favorite_list.as_json(include: :books) }
    end
  end

  def edit
    @favorite_list = FavoriteList.includes(:books).find(params[:id])
  end

  def update
    @favorite_list = FavoriteList.find(params[:id])
    if @favorite_list.update(favorite_list_params)
      redirect_to @favorite_list, notice: 'お気に入りリストが正常に更新されました'
    else
      render :edit
    end
  end
  
  def index 
    @favorite_lists = current_user.favorite_lists
  end

  def add_book
    # 選択された本とお気に入りのリストを取得
    @book = Book.find(params[:book_id])
    favorite_list = FavoriteList.find(params[:id])
    @favorite_list = favorite_list
  
    # リストに本を追加
    unless favorite_list.books.include?(@book)
      favorite_list.books << @book
    end

    respond_to do |format|
      format.js { render 'add_book' }
      format.html { redirect_to favorite_list_path(favorite_list) }
    end
  end

  def books
    @favorite_list = FavoriteList.find(params[:favorite_list_id])
    @books = @favorite_list.books
    render partial: 'books_selection', collection: @books, as: :book
  end

  def remove_book
    @favorite_list = FavoriteList.find(params[:id])
    @book = Book.find(params[:book_id])
    @favorite_list.books.delete(@book)
  
    respond_to do |format|
      format.js { render 'remove_book' } # この行は変更が不要ですが、明示的に示しています
      format.html { redirect_to @favorite_list, notice: 'Book was successfully removed from the list.' }
    end
  end
  
  def destroy
    @favorite_list = FavoriteList.find(params[:id])
    @favorite_list.destroy
    redirect_to favorite_lists_path, notice: 'リストが正常に削除されました。'
  end

  def post
    @favorite_list = FavoriteList.find(params[:id])
    
    if @favorite_list.update(posted: true)
      redirect_to favorite_list_path(@favorite_list), notice: 'リストが投稿されました。'
    else
      redirect_to favorite_list_path(@favorite_list), alert: 'エラーが発生しました。'
    end
  end
  
  private 

  def favorite_list_params
    params.require(:favorite_list).permit(:name, book_ids: [], books_attributes: [:id, :title, :author, :description, :recommended, :publisher, :published_date, :image_url])
  end

end
