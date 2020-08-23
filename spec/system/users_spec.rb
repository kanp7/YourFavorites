require 'rails_helper'

RSpec.describe 'ユーザーのテスト', type: :system do
  describe 'ユーザー新規登録' do
  	before do
  		visit new_user_registration_path
  	end
  		it '新規登録に成功する' do
  			fill_in 'ユーザー名', with: Faker::Internet.username(specifier: 5)
  			fill_in 'Eメール', with: Faker::Internet.email
  			fill_in 'パスワード', with: 'password'
  			fill_in 'パスワード（確認用）', with: 'password'
  			click_on '新規登録'

  			expect(page).to have_content 'アカウント登録が完了しました。'
  		end
  		it '新規登録に失敗する' do
  			fill_in 'ユーザー名', with: ''
  			fill_in 'Eメール', with: ''
  			fill_in 'パスワード', with: ''
  			fill_in 'パスワード（確認用）', with: ''
  			click_on '新規登録'

  			expect(page).to have_content '保存されませんでした。'
  		end
  end

  describe 'ユーザーログイン' do
  	let(:user) { create(:user) }
	  it 'ログインする' do
	    # トップページを開く
	    visit root_path
	    #ログインページに移動する
	    click_link 'ログイン'
	    #ログインフォームにEmailとパスワードを入力する
	    fill_in 'ユーザー名', with: user.name
	    fill_in 'パスワード', with: 'password'
	    #ログインボタンをクリックする
	    click_on 'ログイン'
	    # ログインに成功したことを検証する
	    expect(page).to have_content 'ログインしました'
	  end

	  it 'ログインに失敗する' do
	    # トップページを開く
	    visit root_path
	    #ログインページに移動する
	    click_link 'ログイン'
	    #ログインフォームにEmailとパスワードを入力する
	    fill_in 'ユーザー名', with: ''
	    fill_in 'パスワード', with: ''
	    #ログインボタンをクリックする
	    click_on 'ログイン'
	    # ログインに成功したことを検証する
	    expect(page).to have_content 'が違います。'
	  end

	  it 'ログアウトする' do
	  	# トップページを開く
	    visit root_path
	    #ログインページに移動する
	    click_link 'ログイン'
	    #ログインフォームにEmailとパスワードを入力する
	    fill_in 'ユーザー名', with: user.name
	    fill_in 'パスワード', with: 'password'
	    #ログインボタンをクリックする
	    click_on 'ログイン'
	  	visit user_path(user.id)
	  	#ログアウトをクリックする
	  	#find('.logout').click
	  	click_on 'ログアウト'
	  	#ログアウトに成功したことを検証する
	  	expect(page).to have_content 'ログアウトしました'
	  end
  end

  describe '表示のテスト' do
  	let(:user) { create(:user) }
  	let(:user2) { create(:user)}
  	before do
  		visit new_user_session_path
  		fill_in 'ユーザー名', with: user.name
  		fill_in 'パスワード', with: 'password'
  		click_on 'ログイン'
  	end
  	context 'マイページ' do
	  	it '名前が表示される' do
	  		expect(page).to have_content("#{user.name} さんのページ")
	  	end
	  	it '画像が表示される' do
	  		expect(page).to have_css('img.profile_image')
	  	end
	  	it '自己紹介が表示される' do
	  		expect(page).to have_content(user.introduction)
	  	end
	  	it '編集リンクが表示される' do
	  		expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
	  	end
	  	it '投稿ボタンが表示される' do
	  		expect(page).to have_link '本の感想を投稿'
	  		expect(page).to have_link '映像作品の感想を投稿'
	  	end
  	end
  	context '編集ページ' do
  		it '遷移できる' do
  			visit edit_user_path(user)
  			expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
  		end
  		it '他人の画面へ遷移できない' do
  			visit edit_user_path(user2)
  			expect(current_path).to eq('/users/' + user.id.to_s)
  		end

	  	before do
	  		visit edit_user_path(user)
	  	end
	  	it '名前編集フォームに自分の名前が表示される' do
	  		expect(page).to have_field 'user[name]', with: user.name
	  	end
	  	it '画像編集フォームが表示される' do
	  		expect(page).to have_field 'user[profile_image]'
	  	end
	  	it '自己紹介編集フォームに自己紹介が表示される' do
	  		expect(page).to have_field 'user[introduction]', with: user.introduction
	  	end
	  	it '編集に成功する' do
	  		click_button '更新'
	  		expect(page).to have_content 'ユーザーの情報を更新しました'
	  		expect(current_path).to eq('/users/' + user.id.to_s)
	  	end
	  	it '編集に失敗する' do
	  		fill_in 'ユーザー名' ,with: ''
	  		click_button '更新'
	  		expect(page).to have_content 'ユーザー名を入力してください'
	  		expect(current_path).to eq('/users/' + user.id.to_s)
	  	end
  	end

  end

end