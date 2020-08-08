class UsersController < ApplicationController

	before_action :authenticate_user!, only:[:edit, :update]
	before_action :correct_user, only:[:edit, :update]

  def index
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.posts
    # if @user != nil && @user.profile_image_id != nil
    #   @image_url = "https://yourfavorites-resize.s3-ap-northeast-1.amazonaws.com/store/" + @user.profile_image_id + "-thumbnail."
    # else
    #   @image_url = "/assets/no_image-c7305210e2d30bf8f19461ca05a151bba6413a44a35124f673246160efefdc5e.jpg"
    # end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	if user.update(user_params)
  		flash[:notice] = "ユーザーの情報を更新しました"
  		redirect_to user_path(user.id)
  	else
  		render "edit"
  	end
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).reverse_order
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).reverse_order
    render 'show_follow'
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])

    @sort = params[:sort]
    if @sort == 'new'
      @posts = @posts.page(params[:page]).order(created_at: :DESC)
    elsif @sort == 'old'
      @posts = @posts.page(params[:page]).order(created_at: :ASC)
    elsif @sort == 'favorite'
      @posts = @posts.left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id)')).reverse_order.page(params[:page])
    else
     @posts = @posts.page(params[:page]).reverse_order
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :introduction, :profile_image)
  	end

  	def correct_user
  		user = User.find(params[:id])
  		if current_user != user
  			redirect_to user_path(current_user)
  		end
  	end
end
