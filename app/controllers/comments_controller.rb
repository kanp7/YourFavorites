class CommentsController < ApplicationController

	def create
		comment = Comment.new(comment_params)
		comment.user_id = current_user.id
		if params[:book_id]
			@book = Book.find(params[:book_id])
			comment.post_id = @book.id
			comment.save
			redirect_to book_path(@book)
		else
			@movie = Movie.find(params[:movie_id])
			comment.post_id = @movie.id
			comment.save
			redirect_to movie_path(@movie)
		end
	end

	def destroy
		Comment.find_by(id: params[:id]).destroy
		if params[:book_id]
			redirect_to book_path(params[:book_id])
		else
			redirect_to movie_path(params[:movie_id])
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:comment)
		end
end
