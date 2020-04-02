class UserMailer < ApplicationMailer
  default from: 'postmaster@chienhao.tw'

  def welcome_email
    @user = params[:user]

    @url = 'https://taskmanager0117.herokuapp.com/login'
    mail(to: @user.email, subject: "Welcome to Task Manager")
  end
end
