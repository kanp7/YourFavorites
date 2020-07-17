class UsersController < ApplicationController

	before_action :authenticate_user!, only:[:edit, :update]
	before_action :correct_user, only:[:edit, :update]

  def index
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.posts
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
    @users = @user.following.all
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follow'
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
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
