class StoresController < ApplicationController

before_action :admin_only, only: [:index, :new, :edit, :update, :destroy]

  def index
    @stores = Store.paginate(page: params[:page])
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def show
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "Store added"
      redirect_to stores_path
    else
      render new
    end
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(store_params)
      flash[:success] = "Store info updated!"
      redirect_to @store
    else
      render 'edit'
    end
  end

  def destroy
    
  end

  def destroy
    Store.find(params[:id]).destroy
    flash[:success] = "Store deleted"
    redirect_to stores_url
  end


  private

    def store_params
      params.require(:store).permit(:name, :addr_no)
    end

    def admin_only
      unless logged_in? && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end

end
