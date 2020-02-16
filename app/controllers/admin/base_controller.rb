class Admin::BaseController < ApplicationController
  layout 'backend'
  before_action :login_check
  before_action :admin_check

  # 進入任務管理頁面必須先登入
  def login_check
    if !logged_in?
      redirect_to admin_login_path, notice: '請先登入'
    end
  end
  # 登入使用者必須是管理員角色
  def admin_check
    if !current_user.admin
      redirect_to admin_login_path, notice: '權限不足'
    end
  end
end