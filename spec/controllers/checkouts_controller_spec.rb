require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  describe '#edit_address' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :edit_address, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end

    context 'cancan doesnt allow :edit_address' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :edit_address, @order
      end

      it do
        get :edit_address, id: @order
        expect(response).to redirect_to(index_path)
      end
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

    context 'cancan doesnt allow :edit_delivery' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :edit_delivery, @order
      end

      it do
        get :edit_delivery, id: @order
        expect(response).to redirect_to(index_path)
      end
    end
  end

  describe '#edit_payment' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :edit_payment, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end

    context 'cancan doesnt allow :edit_payment' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :edit_payment, @order
      end

      it do
        get :edit_payment, id: @order
        expect(response).to redirect_to(index_path)
      end
    end
  end

  describe '#confirm' do
    it 'successfully renders page' do
      user = create(:user)
      sign_in user
      get :confirm, id: create(:order, user: user)
      expect(response.status).to eq(200)
    end

    context 'cancan doesnt allow :confirm' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :confirm, @order
      end

      it do
        get :confirm, id: @order
        expect(response).to redirect_to(index_path)
      end
    end
  end

  describe '#update' do
    before do
      @user = create(:user)
      @order = create(:order, user: @user)
      request.env["HTTP_REFERER"] = edit_address_checkout_path(@order)
      sign_in @user
    end

    it 'redirects back when errors' do
      patch :update, id: @order,
        order: { billing_address_attributes: {first_name: nil}, step: :address }
      expect(response).to redirect_to edit_address_checkout_path(@order)
    end

    it 'redirects to next step when no errors' do
      patch :update, id: @order, order: {step: :address }
      expect(response).to redirect_to edit_delivery_checkout_path(@order)
    end

    it 'fails when guest' do
      sign_out @user
      patch :update, id: @order, order: {step: :address }
      expect(response).not_to redirect_to edit_delivery_checkout_path(@order)
    end

    it 'fails when other user' do
      sign_out @user
      sign_in create(:user)
      patch :update, id: @order, order: {step: :address }
      expect(response).not_to redirect_to edit_delivery_checkout_path(@order)
    end

    context 'cancan doesnt allow :update' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :update, @order
      end

      it do
        get :update, id: @order
        expect(response).to redirect_to(index_path)
      end
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

    context 'cancan doesnt allow :place' do
      before do
        @order = create(:order)
        redifine_abilities
        @ability.cannot :place, @order
      end

      it do
        get :place, id: @order
        expect(response).to redirect_to(index_path)
      end
    end
  end
end
