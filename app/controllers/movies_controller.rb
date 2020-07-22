class MoviesController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
	before_action :correct_user, only: [:edit, :update]

  def index
    @sort = params[:sort]
    if @sort == 'new'
      @movies = Movie.page(params[:page]).order(created_at: :DESC)
    elsif @sort == 'old'
      @movies = Movie.page(params[:page]).order(created_at: :ASC)
    elsif @sort == 'favorite'
      @movies = Movie.left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id)')).reverse_order.page(params[:page])
    else
      @movies = Movie.page(params[:page]).reverse_order
    end
  end

  def show
  	@movie = Movie.find(params[:id])
    @comment = Comment.new
  end

  def new
  	@movie = Movie.new
    @movie_categories = MovieCategory.all
  end

  def create
  	movie = Movie.new(movie_params)
  	movie.user_id = current_user.id
  	if movie.save
  		flash[:notice] = "映像作品の感想を投稿しました"
  		redirect_to movie_path(movie.id)
  	else
  		render "new"
  	end
  end

  def edit
  	@movie = Movie.find(params[:id])
    @movie_categories = MovieCategory.all
  end

  def update
  	movie = Movie.find(params[:id])
  	if movie.update(movie_params)
  		flash[:notice] = "映像作品の感想を更新しました"
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
	  	params.require(:movie).permit(:title, :author, :subject, :body, :rating, :category_id)
	  end

	  def correct_user
  		movie = Movie.find(params[:id])
	  		if current_user.id != movie.user_id
	  			redirect_to movies_path
	  		end
  		end
end
