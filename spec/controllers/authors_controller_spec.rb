require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe '#show' do
    context 'when author found' do
      it 'successfully renders page' do
        create(:author, id: 0 )
        get :show, id: 0
        expect(response.status).to eq(200)
      end

      it 'assigns @author' do
        author = create(:author, id: 0)
        get :show, id: 0
        expect(assigns(:author)).to eq author
      end
    end
  end
end
