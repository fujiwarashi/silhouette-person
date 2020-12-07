require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "問題作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_text = Faker::Lorem.sentence
    @choice_text = Faker::Lorem.sentence
    @question_image = Faker::Lorem.sentence
  end
  context '新規問題作成ができるとき'do
    it 'ログインしたユーザーは新規問題作成できる' do
      basic_pass new_user_session_path
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('問題作成')
      # 投稿ページに移動する
      visit new_question_path
      # フォームに情報を入力する
      # fill_in 'question_image', with: @question_image
      fill_in 'question_content', with: @question_text
      fill_in 'answer1', with: @choice_text
      fill_in 'answer2', with: @choice_text
      fill_in 'answer3', with: @choice_text
      fill_in 'answer4', with: @choice_text
      # 送信するとQuestionモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(1)
      # トップページに遷移する
      visit root_path
    end
  end
  context '問題作成できないとき'do
    it 'ログインしていないと新規作成ページに遷移できない' do
    # トップページに遷移する
    visit root_path
    # 新規投稿ページへのリンクがない
    expect(page).to have_no_content('問題作成')
    end
  end
end

RSpec.describe '問題編集', type: :system do
  before do
    @quesiton1 = FactoryBot.create(:question_choice)
    @quesiton2 = FactoryBot.create(:question_choice)
  end
  context '問題編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した問題の編集ができる' do
      # 問題1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @question1.user.email
      fill_in 'password', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに「マイページ」ボタンがあることを確認する
      expect(page).to have_content(@question1.user.name)
    end




      
  #     # 編集ページへ遷移する
  #     visit edit_tweet_path(@tweet1)
  #     # すでに投稿済みの内容がフォームに入っていることを確認する
  #     expect(
  #       find('#tweet_image').value
  #     ).to eq @tweet1.image
  #     expect(
  #       find('#tweet_text').value
  #     ).to eq @tweet1.text
  #     # 投稿内容を編集する
  #     fill_in 'tweet_image', with: "#{@tweet1.image}+編集した画像URL"
  #     fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
  #     # 編集してもTweetモデルのカウントは変わらないことを確認する
  #     expect{
  #       find('input[name="commit"]').click
  #     }.to change { Tweet.count }.by(0)
  #     # 編集完了画面に遷移したことを確認する
  #     expect(current_path).to eq tweet_path(@tweet1)
  #     # 「更新が完了しました」の文字があることを確認する
  #     expect(page).to have_content('更新が完了しました。')
  #     # トップページに遷移する
  #     visit root_path
  #     # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
  #     expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet1.image}+編集した画像URL);']"
  #     # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
  #     expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
  #   end
  # end
  # context 'ツイート編集ができないとき' do
  #   it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
  #     # ツイート1を投稿したユーザーでログインする
  #     # ツイート2に「編集」ボタンがないことを確認する
  #   end
  #   it 'ログインしていないとツイートの編集画面には遷移できない' do
  #     # トップページにいる
  #     # ツイート1に「編集」ボタンがないことを確認する
  #     # ツイート2に「編集」ボタンがないことを確認する
  #   end
  end
end