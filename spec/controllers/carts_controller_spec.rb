require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe "#add" do
    before { request.env["HTTP_REFERER"] = index_url }

    it 'redirects back' do
      patch :add
      expect(response).to redirect_to :back
    end

    context 'when trying to add valid item' do
      it 'adds item to cart' do
        expect(controller.current_cart).to receive(:add).with("0")
        create(:book, id: 0)
        patch :add, book: 0
      end
    end
  end
end
