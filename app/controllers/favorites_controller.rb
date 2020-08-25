class FavoritesController < ApplicationController

	def show
		@favorites = Favorite.where(user_id: params[:user_id]).reverse_order.page(params[:page]).per(10)
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
		#favorites/_book(movie)_favorite(投稿の詳細ページ)からは"show"
		#favorites/show(マイページのお気入り一覧)からは"mypage"のパラメーターを受け取り、結果を分岐。
		case params[:request_from]
		when 'show'
			render :destroy
		when 'mypage'
			redirect_back(fallback_location: root_path)
		end
	end

end
