class Admin::BaseController < ApplicationController
  layout 'backend'

  # 進入任務管理頁面必須先登入
  def login_check
    if !logged_in?
      redirect_to admin_login_path, notice: '請先登入'
    end
  end
end