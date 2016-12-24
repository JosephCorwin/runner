class OrdersController < ApplicationController

before_action :logged_in_user, only: [:new, :show]
before_action :correct_user, only:  [:show]
before_action :admin_only, only: [:edit]

  def new
    @order = current_user.account.orders.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def show
  end

  def create
    @user = current_user
    @order = @user.account.orders.new(order_params)
    if @order.save
      flash[:info] = "Order placed"
      redirect_to root_url
    end
  end

  private
    
    def order_params
      params.require(:order).permit(:what_they_want, :where_it_goes)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to place an order"
        redirect_to login_url
      end
    end

    def correct_user
      @cust = User.find(@order.customer_id)
      @runn = User.find(@order.runner_id)
      redirect_to(root_url) unless current_user?(@cust) || current_user?(@runn) || you_da_boss?(@current_user)
    end
end
