class BooksController < ApplicationController

	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

  def index
  	@books = Book.all
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