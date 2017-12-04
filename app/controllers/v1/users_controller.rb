class V1::UsersController < V1::BaseController
  include Devise::Controllers::Helpers
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
    @user_invite = UserInvite.new(
      employee: user_params,
      creator_id: current_user.id
    )
    if @user_invite.send_invite
      render json: @user_invite.front_view, status: :ok
    else
      render json: @user_invite.errors, status: 400
    end
  end

  def add_social_account
    # TODO: Rewrite social auth, to check auth from backend
    @social_acc = SocialAccount.new(social_params)
    @social_acc.user_id = current_user.id
    if @social_acc.save
      render json: 'ok', status: :ok
    else
      render json: @social_acc.errors, status: 400
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email)
  end

  def social_params
    params.permit(:socialUserId, :platform)
  end
end
