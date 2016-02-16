class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    if params[:redirect]
      params[:redirect]
    else
      current_user_path
    end
  end
end
