class BooksController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
	before_action :correct_user, only: [:edit, :update]

  def index
    @sort = params[:sort]
    if @sort == 'new'
      @books = Book.page(params[:page]).order(created_at: :DESC)
    elsif @sort == 'old'
      @books = Book.page(params[:page]).order(created_at: :ASC)
    elsif @sort == 'favorite'
      @books = Book.left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id)')).reverse_order.page(params[:page])
    else
  	 @books = Book.page(params[:page]).reverse_order
    end
  end

  def show
  	@book = Book.find(params[:id])
  	@comment = Comment.new
  end

  def new
  	@book = Book.new
  	@book_categories = BookCategory.all
  end

  def create
  	book = Book.new(book_params)
  	book.user_id = current_user.id
  	if book.save
  		flash[:notice] = "本の感想を投稿しました"
  		redirect_to book_path(book.id)
  	else
      @book = book
      @book_categories = BookCategory.all
  		render "new"
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  	@book_categories = BookCategory.all
  end

  def update
  	book = Book.find(params[:id])
  	if book.update(book_params)
  		flash[:notice] = "本の感想を更新しました"
  		redirect_to book_path(book.id)
  	else
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private
	  def book_params
	  	params.require(:book).permit(:title, :author, :subject, :body, :rating, :category_id)
	  end

	  def correct_user
  		book = Book.find(params[:id])
	  		if current_user.id != book.user_id
	  			redirect_to books_path
	  		end
  		end
end
