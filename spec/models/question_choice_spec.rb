require 'rails_helper'

RSpec.describe QuestionChoice, type: :model do
  before do
    @question_choice = FactoryBot.build(:question_choice)
  end

  describe '問題作成' do
    context '新規問題作成がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@question_choice).to be_valid
      end
    end

    context '新規問題作成がうまくいかないとき' do
      it 'タイトルが必須でないといけない' do
        @question_choice.content = ''
        @question_choice.valid?
        expect(@question_choice.errors.full_messages).to include("問題名を入力してください")
      end
      it 'メッセージが必須でないといけない' do
        @question_choice.text = ''
        @question_choice.valid?
        expect(@question_choice.errors.full_messages).to include("説明文を入力してください")
      end
    end
  end
end
