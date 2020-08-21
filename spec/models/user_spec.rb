require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'バリデーションのテスト' do
  	let(:user) { User.new(params) }
  	let(:params) { { email: "test@mail.com", password: "password" } }

  	context '名前が登録されている場合' do
  		before do
  			params.merge!(name: "test")
  		end
		it "有効であること" do
			expect(user).to be_valid
		end
	end

	context '名前が登録されていない場合' do
	  	it "エラーメッセージが表示されること" do
	  		user.valid?
		  	expect(user.errors[:name]).to include("を入力してください")
		end
	end

	context '名前が２文字より少ない場合' do
		before do
			params.merge!(name: "a")
		end
		it "エラーメッセージが表示されること" do
			user.valid?
			expect(user.errors[:name]).to include("は2文字以上で入力してください")
		end
	end

	context '名前が20文字より多い場合' do
		before do
			params.merge!(name: "a" * 21)
		end
		it "エラーメッセージが表示されること" do
			user.valid?
			expect(user.errors[:name]).to include("は20文字以内で入力してください")
		end
	end
  end

end
