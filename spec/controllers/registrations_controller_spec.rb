require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    request.env["HTTP_REFERER"] = index_url
    allow(controller).to receive(:resource).and_return(User.new)
    allow(controller).to receive(:resource_name).and_return(:user)
    allow(controller)
      .to receive(:devise_mapping).and_return(Devise.mappings[:user])
  end

  describe '#destroy' do
    it 'redirects back when destroy not confirmed' do
      sign_in create :user
      delete :destroy
      expect(response).to redirect_to :back
    end
  end
end
