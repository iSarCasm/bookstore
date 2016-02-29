class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.create_with_omniauth(request.env["omniauth.auth"])
    render text: request.env["omniauth.auth"].info.email
    # sign_in_and_redirect @user
  end
end
