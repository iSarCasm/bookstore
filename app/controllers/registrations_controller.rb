class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def destroy
    if params[:confirm]
      super
    else
      redirect_to :back
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit({ billing_address_attributes:
                [
                  :id,
                  :first_name,
                  :last_name,
                  :street_address,
                  :city,
                  :country,
                  :zip,
                  :phone
                ]
              },
              { delivery_address_attributes:
                [
                  :first_name,
                  :last_name,
                  :street_address,
                  :city,
                  :country,
                  :zip,
                  :phone
                ]
              },
              :email,
              :password,
              :password_confirmation,
              :current_password)
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
