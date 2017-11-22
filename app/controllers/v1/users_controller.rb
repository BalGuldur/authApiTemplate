class V1::UsersController < V1::BaseController
  before_action :authenticate_user!
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
  end

  def invite
    @user_invite = UserInvite.new(user: user_params, creator_id: current_user.id)
    if @user_invite.send_invite
      render json: @user_invite.front_view, status: :ok
    else
      render json: @user_invite.errors, status: 400
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email)
  end
end
