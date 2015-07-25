class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "Success"
      redirect_to lists_path
    else
      flash[:notice] = "Try Again"
      render :new
    end
  end

  def destroy
    @list = find_list
    @list.destroy
    redirect_to lists_path
  end

  def edit
    @list = find_list
  end

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @lists = List.all
    @list = find_list
  end

  def update
    @list = find_list
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  private

  def find_list
    List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
