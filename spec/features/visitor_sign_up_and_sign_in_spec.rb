require 'rails_helper'

RSpec.describe "the signup & signin process", :type => :feature do
  it 'signs up and signs in' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'new_user_007@mail.com'
    fill_in 'Password',              with: 'password12345'
    fill_in 'Password confirmation', with: 'password12345'
    find('input[name="commit"]').click

    expect(current_path).to eq '/'
    expect(User.count).to eq 1
    expect(User.last.confirmation_token).to_not eq nil

    visit "/users/confirmation?confirmation_token=#{User.last.confirmation_token}"
    visit '/users/sign_in'

    fill_in 'Email', with: 'new_user_007@mail.com'
    fill_in 'Password',              with: 'password12345'
    find('input[name="commit"]').click

    expect(current_path).to eq '/'
    expect(page).to have_content 'Sign Out'
  end
end
