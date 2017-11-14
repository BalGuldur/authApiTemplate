class V1::UsersController < V1::BaseController
  before_action :set_user, only: [:destroy]
  respond_to :json

  def index
    @users = User.all
    render json: @users.front_view, status: :ok
  end

  def destroy
    if @user.destroy
      render json: @user.front_view, status: :ok
    else
      render json: @user.errors, status: 400
    end
    # render json: @user.front_view, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
