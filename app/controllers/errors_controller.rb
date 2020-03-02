class ErrorsController < ApplicationController
  layout 'error'

  # 404
  def not_found
    render status: :not_found
  end
  # 500
  def server_error
    render status: :server_error
  end
end