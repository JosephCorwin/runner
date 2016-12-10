class UsersController < ApplicationController

before_action :logged_in_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Check your email"
       redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Account info updated!"
        redirect_to @user
      else
        render 'edit'
      end
  end

  private
    
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
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
