class TasksController < ApplicationController
  def create
    @list = find_list
    @task = @list.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Success"
      redirect_to @list
    else
      flash[:notice] = "Try Again"
      render :new
    end
  end

  def destroy
    @list = find_list
    find_task.destroy
    redirect_to @list
  end

  def edit
    get_task_and_list
  end

  def new
    @task = Task.new
    @list = find_list
  end

  def show
    @task = Task.find(params[:id])
    @list = List.find(params[:list_id])
  end

  def update
    @list = find_list
    @task = find_task
    @task.update(task_params)
    redirect_to list_path(@list)
  end

  private

  def get_task_and_list
    @list = find_list
    @task = find_task
  end

  def find_task
    Task.find(params[:id])
  end

  def find_list
    List.find(params[:list_id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
