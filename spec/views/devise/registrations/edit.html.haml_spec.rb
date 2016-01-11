require 'rails_helper'

RSpec.describe "devise/registrations/edit", type: :view, verify_stubs: false do
  before do
    allow(view).to receive(:current_user).and_return(User.new)
    allow(view).to receive(:resource).and_return(User.new)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    assign(:billing_address, Address.new)
    assign(:delivery_address, Address.new)
  end

  describe 'Email section' do
    it 'has Email field' do
      render
      expect(rendered).to have_field 'Email'
    end
  end

  describe 'Password section' do
    it "has 'Old Password' field" do
      render
      expect(rendered).to have_field 'Old Password'
    end

    it "has 'New Password' field" do
      render
      expect(rendered).to have_field 'New Password'
    end

    it "has 'Password Confirmation' field" do
      render
      expect(rendered).to have_field 'Password Confirmation'
    end
  end

  describe 'Remove account section' do
    it 'has "Remove Account" button' do
      render
      expect(rendered).to have_button 'Please Remove My Account'
    end

    it 'has "Are you sure" checkbox' do
      render
      expect(rendered).to have_selector "input[type=checkbox]"
    end
  end
end
