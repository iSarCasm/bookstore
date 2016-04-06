require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    it 'successfully renders page' do
      sign_in create(:user)
      get :index
      expect(response.status).to eq(200)
    end

    it 'assigns @orders' do
      user = create(:user)
      order = create(:order, user: user)
      sign_in user
      get :index
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe '#show' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :show, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end

    context 'cancan doesnt allow :show' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :show, @order
      end

      it do
        get :show, id: @order
        expect(response).to redirect_to(index_path)
      end
    end
  end
end
