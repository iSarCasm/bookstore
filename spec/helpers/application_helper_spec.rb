require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#html_for_errors' do
    let(:errors) { ['stahp', 'plz'] }

    it 'returns pretty bootstrap html styled errors' do
      expect(helper.html_for_errors(errors)).to eq(
        '
        <div class="alert alert-danger">
          <ol>
            <li>stahp</li>
            <li>plz</li>
          </ol>
        </div>
        '.squish.gsub(/\s\</, "<")
      )
    end

    it 'alert style depends on "type" params' do
      expect(helper.html_for_errors(errors, type: 'info')).to eq(
        '
        <div class="alert alert-info">
          <ol>
            <li>stahp</li>
            <li>plz</li>
          </ol>
        </div>
        '.squish.gsub(/\s\</, "<")
      )
    end
  end
end
