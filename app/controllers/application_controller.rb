class ApplicationController < ActionController::Base
  before_action :check_account_status
    protected

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  def check_account_status
    if current_user && current_user.deactivated == true
      sign_out current_user
      flash[:error] = "Your account has been deactivated by the admin."
      redirect_to root_path
    end
  end
end
