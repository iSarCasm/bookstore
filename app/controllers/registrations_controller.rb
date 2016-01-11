class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def edit
    @billing_address = current_user.billing_address
    @delivery_address = current_user.delivery_address
    super
  end

  def update
    @billing_address = current_user.billing_address
    @delivery_address = current_user.delivery_address
    super do
  end

  def destroy
    if params[:confirm]
      super
    else
      redirect_to :back
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update).push(billing_address: [:first_name, :last_name, :street_address, :city, :country, :zip, :phone])
  end

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
