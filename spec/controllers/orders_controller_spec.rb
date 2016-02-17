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

  describe '#edit_address' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :edit_address, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end
  end

  describe '#edit_delivery' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :edit_delivery, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end

    it 'assigns @available_shipments' do
      user = create(:user)
      shipment = create(:shipment)
      sign_in user
      get :edit_delivery, id: create(:order, user: user)
      expect(assigns(:available_shipments)).to eq(Shipment.all.to_a)
    end
  end

  describe '#edit_payment' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :edit_payment, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end
  end

  describe '#confirm' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :confirm, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :show, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    before do
      user = create(:user)
      @order = create(:order, user: user)
      request.env["HTTP_REFERER"] = edit_address_order_path(@order)
      sign_in user
    end

    it 'redirects back when errors' do
      patch :update, id: @order,
        order: { billing_address_attributes: {first_name: nil}, step: :address }
      expect(response).to redirect_to edit_address_order_path(@order)
    end

    it 'redirects to next step when no errors' do
      patch :update, id: @order, order: {step: :address }
      expect(response).to redirect_to edit_delivery_order_path(@order)
    end
  end

  describe '#place' do
    it 'successfully redirects to order' do
      user = create(:user)
      order = create(:order, user: user)
      sign_in user
      post :place, id: order
      expect(response).to redirect_to order
    end

    it 'enqueus the order' do
      user = create(:user)
      order = create(:order, user: user)
      sign_in user
      post :place, id: order
      expect(order.reload.aasm_state).to eq "in_queue"
    end
  end
end
