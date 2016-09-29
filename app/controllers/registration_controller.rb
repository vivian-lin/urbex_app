class RegistrationController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    profile_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :user_description, :image)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :user_description, :image)
  end
end
