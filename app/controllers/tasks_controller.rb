# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
# Your comment
class TasksController < ApplicationController
  before_action :find_task, only: %i[edit show update destroy]
  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '建立成功'
    else
      @error_message = @task.errors.full_messages.to_sentence
      flash[:notice] = '建立失敗'
      render :new
      # render :new, notice: "建立失敗"
      # 這裡的 render :new, notice: "建立失敗"
      # 其實是類似 render partial 的概念， 把 notice:"建立失敗" 當參數帶進去
      # 所以後面的 notice:"建立失敗 是沒有作用的
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '更新成功'
    else
      @error_message = @task.errors.full_messages.to_sentence
      flash[:notice] = '編輯失敗'
      render :edit
    end
  end

  def edit; end

  def show; end

  def destroy
    return redirect_to tasks_path, notice: '刪除成功' if @task.destroy
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:title,
                                 :content,
                                 :task_begin,
                                 :task_end,
                                 :priority,
                                 :status)
  end
end
# rubocop:enable Style/AsciiComments
