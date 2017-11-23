class V1::UserInvitesController < V1::BaseController
  before_action :set_user_invite, only: [:destroy]
  before_action :set_user_inv_by_token, only: [:registration]

  def index
    @user_invites = UserInvite.all
    render json: @user_invites.front_view, status: :ok
  end

  def destroy
    if @user_invite.destroy
      render json: @user_invite.front_view, status: :ok
    else
      render json: @user_invite.errors, status: 400
    end
  end

  def registration
    render json: {error: 'Некорректный токен'}, status: 400 if @user_invite.blank?
    @user = @user_invite.reg reg_params
    if @user.save
      # TODO: Add set current user, return Auth header
      render json: @user.front_view, status: :ok
    else
      render json: @user.errors, status: 400
    end
  end

  private

  def set_user_invite
    @user_invite = UserInvite.find(params[:id])
  end

  def set_user_inv_by_token
    @user_invite = UserInvite.find_by(token: params[:token])
  end

  def reg_params
    params.permit(:email, :password)
  end
end
