require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:category) { Category.new( category: '小説')}
  let!(:category2) { Category.new( category: '映画')}
  let!(:book) { create(:book, user: user) }
  let!(:book2) { create(:book, user: user2) }
  let!(:movie) { create(:movie, user: user) }
  let!(:movie2) { create(:movie, user: user2) }
  before do
  	visit new_user_session_path
  	fill_in 'user[name]', with: user.name
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
  end

  	it '投稿に成功する' do
  		visit new_book_path
  		fill_in '作品名', with: Faker::Lorem.characters(number:5)
  		fill_in '作者', with: Faker::Lorem.characters(number:5)
  		fill_in '件名', with: Faker::Lorem.characters(number:5)
  		fill_in '本文', with: Faker::Lorem.characters(number:5)
  		select '小説', from: 'book_category_id'
  		click_button '投稿'
  		expect(page).to have_content '投稿しました'
  	end

end
