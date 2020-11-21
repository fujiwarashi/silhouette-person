require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it '名前が6文字以下で登録できる' do
        @user.name = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上であれば登録できる' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it '名前が必須でないといけない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it '名前が20文字以下でないといけない' do
        @user.name = '123456789012345678901'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は20文字以内で入力してください")
      end
      it 'メールアドレスが必須でないといけない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスが一意性であり、重複しては登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが入力されていないといけない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードには英字と数字の両方を含めて設定してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードは、5文字以下でなければ登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'パスワードは、半角英数字混合での入力が必須でなければならない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'パスワードは、確認用も入力しなければならない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードとパスワード（確認用）、値の一致しなければならない' do
        @user.password == @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
