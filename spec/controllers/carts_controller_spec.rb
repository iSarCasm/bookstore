require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe "#add" do
    before { request.env["HTTP_REFERER"] = index_url }

    it 'redirects back' do
      patch :add
      expect(response).to redirect_to :back
    end

    context 'when trying to add valid item' do
      # wtf ?
      it 'adds item to cart' do
        create(:book, id: 0)
        expect{patch :add, book: 0}.to change{controller.current_cart.items}
      end
    end
  end
end
