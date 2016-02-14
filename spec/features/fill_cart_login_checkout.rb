require 'rails_helper'

RSpec.describe "fill cart -> login -> checkout", :type => :feature, js: true do
  it 'fill cart -> login -> checkout' do
    user = create(:user)
    book_1 = create(:book)
    book_2 = create(:book)

    expect(Book.count).to eq 2

    visit book_path(book_1)
    sleep 5
    click_on 'Add to Cart'
    click_on 'Add to Cart'

    expect(page).to have_content 'CART (2 ITEMS)'

    visit book_path(book_2)
    click_on 'Add to Cart'

    expect(page).to have_content 'CART (3 ITEMS)'

    click_on 'CART (3 ITEMS)'
    click_on 'Checkout'

    expect(current_path).to eq '/users/sign_in'

    fill_in 'Email', with: 'new_user_007@mail.com'
    fill_in 'Password',              with: 'password12345'
    find('input[name="commit"]').click

    click_on 'CART (3 ITEMS)'
    click_on 'Checkout'
  end
end
