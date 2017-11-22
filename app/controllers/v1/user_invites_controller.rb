class V1::UserInvitesController < V1::BaseController
  before_action :set_user_invite, only: [:destroy]

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

  private

  def set_user_invite
    @user_invite = UserInvite.find(params[:id])
  end
end
