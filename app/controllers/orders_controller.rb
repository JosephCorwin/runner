class OrdersController < ApplicationController

#callbacks
before_action :logged_in_user, only: [:new, :show]
before_action :admin_only,     only: [:index, :edit, :update]
before_action :set_order_cust, only: [:show,  :edit, :update]
before_action :set_runn,       only: [:show,  :runn]
before_action :correct_user,   only: [:show]
 
#RESTful function
#visibile
  def index
    @orders = Order.all
  end

  def new
    @order = current_user.account.orders.new
  end

  def edit
  end

  def show
  end

#invisible
  def create
    user = current_user
    @order = user.account.orders.new(order_params)
    if @order.save
      flash[:info] = "Order placed"
      redirect_to @order
    else
      flash[:warning] = "Order could not be placed"
      render 'new'
    end
    

  end

  def update
    if @order.update_attributes(assignment_params)
      flash[:success] = "Order assigned"
      redirect_to @order
    else
      render 'edit'
    end
  end
    

  private

    def set_order_cust
      @order = Order.find(params[:id])
      @cust = User.find(@order.customer_id)
    end

    def set_runn
      @runn = User.find(@order.runner_id)
    end

    def order_params
      params.require(:order).permit(:what_they_want, :where_it_goes)
    end

    def assignment_params
      params.require(:order).permit(:runner_id, :where_to_get)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to place an order"
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@cust) || current_user?(@runn) || you_da_boss?
    end

    def admin_only
      unless logged_in? && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end
end
