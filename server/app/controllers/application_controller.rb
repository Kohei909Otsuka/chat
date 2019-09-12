class ApplicationController < ActionController::API
  include ActionController::Cookies

  private

  def err_res(errs, status_sym)
    render json: {errs: errs},
      status: status_sym
  end
end
