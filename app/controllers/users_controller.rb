class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :not_signed_in, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page ])
    render 'show_follow'
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      redirect_to users_url, notice: "You can't delete an admin user"
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def not_signed_in
      unless !signed_in?
        store_location
        redirect_to root_url, notice: "Can't create a new user while logged in"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
