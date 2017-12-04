class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!, only: [:check]
  respond_to :json

  # Check user token
  def check
    if user_signed_in?
      render json: current_user.front_view['users'][current_user.id], status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end

  def sign_in_with_vk
    @social_account = SocialAccount.where(platform: 'vk').find_by(vk_params)
    @user = @social_account.user
    if @user.present?
      sign_in @user
      # sign_in = @user
      render json: @user.front_view, status: :ok
    else
      # TODO: Change string to i18n
      render json: 'Не авторизован', status: 404
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #
  private

  def vk_params
    params.permit(:socialUserId)
  end
end
