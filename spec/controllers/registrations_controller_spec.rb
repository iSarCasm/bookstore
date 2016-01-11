require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    request.env["HTTP_REFERER"] = index_url
    @user = create :user
    allow(controller).to receive(:resource).and_return(@user)
    allow(controller).to receive(:resource_name).and_return(:user)
    allow(controller)
      .to receive(:devise_mapping).and_return(Devise.mappings[:user])
  end

  describe '#destroy' do
    it 'destroys user when confirmed' do
      sign_in @user
      expect{delete :destroy, confirm: true}.to change{User.count}
      expect(response).to redirect_to index_url
    end

    it 'redirects back when destroy not confirmed' do
      sign_in create :user
      expect{delete :destroy}.to_not change{User.count}
      expect(response).to redirect_to :back
    end
  end
end
