
require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  describe "abilities of admin" do
    let(:admin) { create(:user, admin: true) }
    let(:ability)  { Ability.new(admin) }

    before do
      create(:order, user: admin)
    end

    context 'can' do
      it { expect(ability).to be_able_to(:manage, :all) }
    end
  end

  describe "abilities of user" do
    let(:user)      { create(:user) }
    let(:ability)   { Ability.new(user) }

    before do
      create(:order, user: user)
    end

    context 'can' do
      it { expect(ability).to be_able_to(:read, Book) }
      it { expect(ability).to be_able_to(:read, Author) }
      it { expect(ability).to be_able_to(:show, Category) }
      it { expect(ability).to be_able_to(:read, Review) }

      it { expect(ability).to be_able_to(:create, Review) }
      it { expect(ability).to be_able_to(:manage, user) }
      it { expect(ability).to be_able_to(:index, create(:order, user: user)) }
      it { expect(ability).to be_able_to(:show, create(:order, user: user)) }
    end

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, :all) }
      it { expect(ability).not_to be_able_to(:manage, Book) }
      it { expect(ability).not_to be_able_to(:manage, Category) }
      it { expect(ability).not_to be_able_to(:access, :rails_admin) }
      it { expect(ability).not_to be_able_to(:dashboard, :rails_admin) }
      it { expect(ability).not_to be_able_to(:index, create(:order, user: create(:user))) }
      it { expect(ability).not_to be_able_to(:show, create(:order, user: create(:user))) }
    end
  end

  describe "abilities of guest" do
    let(:user)      { User.new }
    let(:ability)   { Ability.new(user) }

    before do
      create(:order, user: user)
    end

    context 'can' do
      it { expect(ability).to be_able_to(:read, Book) }
      it { expect(ability).to be_able_to(:read, Author) }
      it { expect(ability).to be_able_to(:show, Category) }
      it { expect(ability).to be_able_to(:read, Review) }
    end

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, :all) }
      it { expect(ability).not_to be_able_to(:manage, Book) }
      it { expect(ability).not_to be_able_to(:manage, Category) }
      it { expect(ability).not_to be_able_to(:access, :rails_admin) }
      it { expect(ability).not_to be_able_to(:dashboard, :rails_admin) }
      it { expect(ability).not_to be_able_to(:index, create(:order, user: create(:user))) }
      it { expect(ability).not_to be_able_to(:show, create(:order, user: create(:user))) }
    end
  end
end
