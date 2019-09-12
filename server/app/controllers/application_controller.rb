class ApplicationController < ActionController::API

  private

  def err_res(errs, status_sym)
    render json: {errs: errs},
      status: status_sym
  end
end
