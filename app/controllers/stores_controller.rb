class StoresController < ApplicationController
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
end
