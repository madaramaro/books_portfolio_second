require 'httparty'
require 'cgi'  # 日本語（非ASCII文字）のため

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  BASE_URL = "https://www.googleapis.com/books/v1/volumes?maxResults=40&q="

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show; end

  # GET /books/new
  def new
    @book = Book.new(book_params_from_search)
  end

  # GET /books/1/edit
  def edit; end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /books/search_online
  def search_online
    # ISBNベースの検索
    if params[:isbn].present?
      isbn = params[:isbn]
      response = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
      @online_books = JSON.parse(response.body)["items"]
      
      # 最初の1件だけを取得
      @online_books = [@online_books.first] if @online_books
    
    # キーワードベースの検索
    elsif params[:keyword].present?
      encoded_keyword = CGI.escape(params[:keyword])
      response = HTTParty.get("#{BASE_URL}#{encoded_keyword}")
      @online_books = response.parsed_response["items"]
    end
  end
    
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author, :description, :recommended, :publisher, :published_date, :image_url)
  end

  def book_params_from_search
    params.permit(:title, :author, :publisher, :published_date, :image_url)
  end
end
