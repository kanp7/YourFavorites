require 'rails_helper'

RSpec.describe "ｍ" do

  describe 'バリデーションのテスト' do
  	let(:user) { build(:user) }
  	context '入力欄がすべて記入されている場合' do
		it "有効であること" do
			expect(user).to be_valid
		end
	end

  	subject { user.errors[:name] }
	context '名前が登録されていない場合' do
	  	before do
	  		user.name = ""
	  		user.valid?
	  	end
		  	it { is_expected.to include("を入力してください") }
	end

	context '名前が２文字より少ない場合' do
		before do
			user.name = "a"
			user.valid?
		end
			it { is_expected.to include("は2文字以上で入力してください") }
	end

	context '名前が20文字より多い場合' do
		before do
			user.name = "a" * 21
			user.valid?
		end
			it { is_expected.to include("は20文字以内で入力してください") }
	end

	context 'emailアドレスが空欄の場合' do
		it "エラーメッセージが表示されること" do
			user.email = nil
			user.valid?
			expect(user.errors[:email]).to include("を入力してください")
		end
	end

	context '登録済のemailアドレスが再度登録された場合' do
		it "エラーメッセージが表示されること" do
			email = Faker::Internet.email
			user = create(:user, email: email)
			user2 = build(:user, email: email)
			user2.valid?
			expect(user2.errors[:email]).to include("はすでに存在します")
		end
	end

	context 'パスワードが空欄の場合' do
		it 'エラーメッセージが表示されること' do
			user.password = nil
			user.valid?
			expect(user.errors[:password]).to include("を入力してください")
		end
	end

	context 'パスワードが5文字以下の場合' do
		it 'エラーメッセージが表示されること' do
			user.password =  Faker::Internet.password(min_length: 5, max_length: 5)
			user.valid?
			expect(user.errors[:password]).to include("は6文字以上で入力してください")
		end
	end

	context 'パスワードと確認が一致していない場合' do
		it 'エラーメッセージが表示されること' do
			user.password_confirmation = "pass"
			user.valid?
			expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
		end
	end


  end

end
