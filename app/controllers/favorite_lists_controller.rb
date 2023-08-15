class FavoriteListsController < ApplicationController

  def new
    @favorite_list = FavoriteList.new
    @books = Book.all  # こちらの行を追加
  end

  def create
    @favorite_list = FavoriteList.new(favorite_list_params)
    if @favorite_list.save
      redirect_to @favorite_list
    else 
      @books = Book.all  # もし保存が失敗した場合も、@booksを再取得
      render 'new'
    end
  end

  def show
    @favorite_list = FavoriteList.find(params[:id])
  
    respond_to do |format|
      format.html
      format.json { render json: @favorite_list }
    end
  end
  
  def index 
    @favorite_lists = FavoriteList.all 
  end

  def add_book
    book = Book.find(params[:book_id])
    favorite_list = FavoriteList.find(params[:id])
    FavoriteListItem.add_book_to_list(book, favorite_list)
    redirect_to favorite_list_path(favorite_list)
  end

  private 

  def favorite_list_params
    params.require(:favorite_list).permit(:name, book_ids: [])  # book_ids: [] を追加
  end

end
