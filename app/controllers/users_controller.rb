class UsersController < ApplicationController

before_action :logged_in_user, only: [:show, :edit, :update]
before_action :correct_user, only:   [:show, :edit, :update]
before_action :admin_only, only:     [:index, :destroy]
before_action :set_user, only:       [:show, :edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
    if @user.save
       @user.send_activation_email
       flash[:info] = "Check your email"
       redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      if @user.update_attributes(user_params)
        flash[:success] = "Account info updated!"
        redirect_to @user
      else
        render 'edit'
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name, 
                                   :email, 
                                   :phone, 
                                   :password, 
                                   :password_confirmation )
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || you_da_boss?
    end

    def admin_only
      unless logged_in? && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end

end
