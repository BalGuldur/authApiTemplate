class V1::SocialAccountsController < V1::BaseController
  before_action :set_social_account, only: [:destroy]

  def index
    @social_accounts = current_user.social_accounts
    render json: @social_accounts.front_view, status: :ok
  end

  def destroy
    if @social_account.destroy
      render json: @social_account.front_view, status: :ok
    else
      render json: @social_account.errors, status: 400
    end
  end

  private

  def set_social_account
    @social_account = SocialAccount.find(params[:id])
  end
end
