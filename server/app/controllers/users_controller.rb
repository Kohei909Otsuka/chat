class UsersController < ApplicationController
  skip_before_action :set_current_user, only: [:create]

  def create
    r = User.register(
      user_params[:name],
      user_params[:email],
      user_params[:password]
    )

    if !r.success?
      err_res(r.errs, :unprocessable_entity)
      return
    end

    user = r.data
    json = UserSerializer.new(user)
      .serializable_hash
    render json: json, status: :ok
  end

  private

  # Strong Paramter
  def user_params
    params.permit(:name, :email, :password)
  end
end
