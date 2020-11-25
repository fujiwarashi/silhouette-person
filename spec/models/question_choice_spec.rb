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
      it '問題文が必須でないといけない' do
        @question_choice.content = ''
        @question_choice.valid?
        expect(@question_choice.errors.full_messages).to include("問題文を入力してください")
      end
      it '選択肢が必須でないといけない' do
        @question_choice.text[0][:tex] = ''
        @question_choice.valid?
        expect(@question_choice.errors.full_messages).to include("選択肢1が選択されていません")
      end
      it '正解が選択されていないといけない' do
        @question_choice.answer_id[0][:ans] = '{"ans"=>"1"}'
        @question_choice.valid?
        expect(@question_choice.errors.full_messages).to include()
      end
    end
  end
end
