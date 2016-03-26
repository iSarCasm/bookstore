require 'rails_helper'

RSpec.describe CallbacksController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["HTTP_REFERER"] = index_url
  end

  describe '#facebook' do
    it 'gets user with omniauth' do
      expect(User).to receive(:create_with_omniauth).and_return(create(:user))
      get :facebook
    end

    it 'redirects back' do
      user = create(:user)
      allow(User).to receive(:create_with_omniauth).and_return(user)
      get :facebook
      expect(response).to redirect_to index_url
    end
  end

  describe '#github' do
    it 'gets user with omniauth' do
      expect(User).to receive(:create_with_omniauth).and_return(create(:user))
      get :github
    end

    it 'redirects back' do
      user = create(:user)
      allow(User).to receive(:create_with_omniauth).and_return(user)
      get :github
      expect(response).to redirect_to index_url
    end
  end
end
