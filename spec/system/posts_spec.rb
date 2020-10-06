require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:category) { BookCategory.create!( category: '小説')}
  let!(:category2) { MovieCategory.create!( category: '映画')}
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

  context '新規投稿' do
    it '新規投稿ページへ遷移する' do
      visit new_book_path
      expect(page).to have_content '新規投稿'
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

     it '投稿に失敗する' do
       visit new_book_path
       click_button '投稿'
       expect(page).to have_content 'カテゴリーを入力してください'
     end
  end

  context '投稿編集' do
    it '編集ページへ遷移する' do
      visit edit_book_path(book)
      expect(current_path).to eq('/books/' + book.id.to_s + '/edit')
    end

    it '他人の編集ページへ遷移できない' do
      visit edit_book_path(book2)
      expect(current_path).to eq('/books')
    end

    it '編集に成功する' do
      visit edit_book_path(book)
      click_button '投稿'
      expect(page).to have_content '更新しました'
      expect(current_path).to eq '/books/' + book.id.to_s
    end

    it '編集に失敗する' do
      visit edit_book_path(book)
      fill_in '作品名', with: ''
      click_button '投稿'
      expect(page).to have_content '入力してください'
      expect(current_path).to eq '/books/' + book.id.to_s
    end
  end

  context '投稿一覧' do
    it '自分の投稿が一覧に表示される' do
      visit user_posts_user_path(user)
      expect(page).to have_content book.title
      expect(page).to have_content book.subject
    end
  end

end
