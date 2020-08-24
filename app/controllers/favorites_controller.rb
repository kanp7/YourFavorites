class FavoritesController < ApplicationController

	def show
		@favorites = Favorite.where(user_id: params[:user_id]).page(params[:page]).per(10)
	end

	def create
		if params[:book_id]
			@book = Book.find(params[:book_id])
			favorite = current_user.favorites.new(post_id: @book.id)
			favorite.save
			post = Post.find(params[:book_id])
			post.create_notification_by!(current_user)
			@check = "book"
		else
			@movie = Movie.find(params[:movie_id])
			favorite = current_user.favorites.new(post_id: @movie.id)
			favorite.save
			post = Post.find(params[:movie_id])
			post.create_notification_by!(current_user)
			@check = "movie"
		end
	end

	def destroy
		if params[:book_id]
			@book = Book.find(params[:book_id])
			favorite = current_user.favorites.find_by(post_id: @book.id)
			favorite.destroy
			@check = "book"
		else
			@movie = Movie.find(params[:movie_id])
			favorite = current_user.favorites.find_by(post_id: @movie.id)
			favorite.destroy
			@check = "movie"
		end
	end

	def index_destroy
		if params[:book_id]
			@book = Book.find(params[:book_id])
			favorite = current_user.favorites.find_by(post_id: @book.id)
			favorite.destroy
			redirect_back(fallback_location: root_path)
		else
			@movie = Movie.find(params[:movie_id])
			favorite = current_user.favorites.find_by(post_id: @movie.id)
			favorite.destroy
			redirect_back(fallback_location: root_path)
		end
	end

end
