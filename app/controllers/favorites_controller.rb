class FavoritesController < ApplicationController

	def show
		@favorites = Favorite.where(user_id: params[:user_id])
	end

	def create
		if params[:book_id]
			@book = Book.find(params[:book_id])
			favorite = current_user.favorites.new(post_id: @book.id)
			favorite.save
			redirect_to book_path(@book)
		else
			@movie = Movie.find(params[:movie_id])
			favorite = current_user.favorites.new(post_id: @movie.id)
			favorite.save
			redirect_to movie_path(@movie)
		end
	end

	def destroy
		if params[:book_id]
			@book = Book.find(params[:book_id])
			favorite = current_user.favorites.find_by(post_id: @book.id)
			favorite.destroy
			redirect_to book_path(@book)
		else
			@movie = Movie.find(params[:movie_id])
			favorite = current_user.favorites.find_by(post_id: @movie.id)
			favorite.destroy
			redirect_to movie_path(@movie)
		end
	end

end
