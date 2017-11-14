class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?

  # Check current_tenant
  set_current_tenant_through_filter
  before_action :find_current_tenant

  # Метод установки текущего тенанта
  def find_current_tenant
    if current_user
      # If user authenticate
      set_current_tenant(current_user.company)
    end
  end

  protected

  def json_request?
    request.format.json?
  end
end
