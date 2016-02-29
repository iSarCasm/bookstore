class RegistrationsController < Devise::RegistrationsController
  def destroy
    if params[:confirm]
      super
    else
      redirect_to :back
    end
  end

  private

  def update_resource(resource, params)
    if params.include? "password"
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end
end
