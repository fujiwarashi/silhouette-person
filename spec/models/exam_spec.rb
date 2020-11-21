require 'rails_helper'

RSpec.describe Exam, type: :model do
  before do
    @exam = FactoryBot.build(:exam)
  end

  describe '試験作成' do
    context '新規試験作成がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@exam).to be_valid
      end
    end

    context '新規試験作成がうまくいかないとき' do
      it 'タイトルが必須でないといけない' do
        @exam.title = ''
        @exam.valid?
        expect(@exam.errors.full_messages).to include("試験名を入力してください")
      end
      it 'メッセージが必須でないといけない' do
        @exam.message = ''
        @exam.valid?
        expect(@exam.errors.full_messages).to include("説明文を入力してください")
      end
      it '問題を一つでも選択肢していないといけない' do
        @exam.question_ids = ''
        @exam.valid?
        expect(@exam.errors.full_messages).to include("問題を入力してください")
      end
    end
  end
end