require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe 'topページ' do
    context "topページが正しく表示される" do
      before do
        get root_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'タイトルが正しく表示されること' do
      	expect(response.body).to include ('Your Favorites へようこそ')
      end
    end
  end
end
