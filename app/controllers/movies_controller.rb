class MoviesController < ApplicationController

	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

  def index
  	@movies = Movie.all
  end

  def show
  	@movie = Movie.find(params[:id])
  end

  def new
  	@movie = Movie.new
  end

  def create
  	movie = Movie.new(movie_params)
  	movie.user_id = current_user.id
  	if movie.save
  		flash[:notice] = "映画の感想を投稿しました"
  		redirect_to movie_path(movie.id)
  	else
  		render "new"
  	end
  end

  def edit
  	@movie = Movie.find(params[:id])
  end

  def update
  	movie = Movie.find(params[:id])
  	if movie.update(movie_params)
  		flash[:notice] = "映画の感想を更新しました"
  		redirect_to movie_path(movie.id)
  	else
  		render "edit"
  	end
  end

  def destroy
  	movie = Movie.find(params[:id])
  	movie.destroy
  	redirect_to movies_path
  end


  private
	  def movie_params
	  	params.require(:movie).permit(:title, :author, :subject, :body, :rating)
	  end

	  def correct_user
  		movie = Movie.find(params[:id])
	  		if current_user.id != movie.user_id
	  			redirect_to movies_path
	  		end
  		end
end
