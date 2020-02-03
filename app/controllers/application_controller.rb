# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
# Your comment
class ApplicationController < ActionController::Base
  before_action :set_locale, :set_ransack_obj
  around_action :switch_locale
  helper_method :current_user, :logged_in?

  # 設定語系
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # 語係切換
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  # 使用者選擇語係後可持續在其他頁面使用該語系
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  # 從子網域取得locale code
  def extract_locale_from_tld
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # 設定Ransack::Search 的實體
  def set_ransack_obj
    @q = Task.ransack(params[:q])
  end

  # 設定當下登入的使用者
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  # 確認使用者是否已登入
  def logged_in?
    !!current_user
  end
  # 進入任務管理頁面必須先登入
  def login_check
    if !logged_in?
      redirect_to root_path, notice: '請先登入'
    end
  end
  # 讓使用者只能管理自己的帳戶
  def same_user_check
    if !(current_user.id == @user.id) && !@current_user.admin
      redirect_to tasks_path, notice: "你只能編輯或刪除自己的帳戶"
    end
  end
end
# rubocop:enable Style/AsciiComments
