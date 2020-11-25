## アプリケーション名
# silhouette person

## アプリケーション概要
Web試験アプリ。製作者が問題を作成、受験者が受験することができるアプリケーション。
また個人での参加も出来るので個人で楽しむ検定やクイズとして楽しむことも出来る。

## URL
<!-- デプロイ済みのURLを記述しましょう。デプロイが済んでいない場合は、デプロイ次第記述しましょう。 -->

## テスト用アカウント
<!-- ログイン機能等を実装した場合は、記述しましょう。またBasic認証等を設けている場合は、そのID/Passも記述しましょう。 -->

## 利用方法
<!-- このアプリケーションの利用方法を説明しましょう。 -->

## 目指した課題解決
前職での採用面接時に行っていた入社試験は試験を印刷、受験者が手書き、面接官が入力して人事へ送信という工程。以上の効率の悪さを改善するため。
またコロナ禍が続く中、リモートでの面接やWeb試験などが増えているのを鑑み、SPIのような共通試験では実現できない会社ごとに合わせた問題を作成、受験できるアプリケーション。

## 洗い出した要件
<!-- スプレッドシートにまとめた要件定義を、マークダウンで記述しなおしましょう。 -->

## 実装した機能についてのGIFと説明
![22ce187fd91b4720507a80ab20fef50a](https://user-images.githubusercontent.com/72442462/99980136-3d10ae80-2deb-11eb-9c08-579755f5b321.gif)


- 問題機能
企業がそれぞれの会社にあった問題を用意することが出来る機能です。
写真や配点も自分で用意でき、四択だけでなく一問多答にも対応しています。
![d82bfb2c155db06b1a0c8521c0c7f1b9](https://user-images.githubusercontent.com/72442462/99981100-4ea68600-2dec-11eb-9ca7-a562f3ec4027.gif)


- 試験機能
問題を組み合わせることで一つの試験として完成することができます。
作成時に作った問題の中から選ぶことができ、公開・非公開設定ができます。
試験ページは暗号化しておりid番号で遷移できないようになっています。
![4b913a9913561f75ac73855572c996d9](https://user-images.githubusercontent.com/72442462/99983932-d5a92d80-2def-11eb-87fa-ba84eac5e85d.gif)


- 結果機能
試験の結果をすぐに表示する機能です。視覚的にわかりやすい正誤表記に加え、配点を出力することで合計点も表示されるようになっています。
![2d251cc8a6fe248006ebe31bb838bf68](https://user-images.githubusercontent.com/72442462/99986264-4e10ee00-2df2-11eb-8806-4132ac66fe1a.gif)


- 履歴機能
試験を作った側、受験した側それぞれが今までの履歴を閲覧できるようになっています。また試験や問題の修正・削除を行うこともできるようになっています。
![50b325a25cb9d0139ce755b8f2e805a9](https://user-images.githubusercontent.com/72442462/99985972-f7a3af80-2df1-11eb-80b8-9971566c1ef4.gif)

## 実装予定の機能
- 希望者へは受験終了時にメール自動送信機能
- ジャンルを設けて公開試験にタグ機能
- 非公開ユーザー向けにURLのQRコード発行機能

## データベース設計
![76474DA6-4B03-4ABD-9938-9726B09D8C6C](https://user-images.githubusercontent.com/72442462/99974950-f1f39d00-2de4-11eb-886b-66e436c1fcca.jpeg)
  

## ローカルでの動作方法
	git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記述しましょう。この時、アプリケーション開発に使用した環境を併記することを忘れないでください（パッケージやRubyのバージョンなど）。


# テーブル設計

## users テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| name                    	| string       	| NOT NULL          	|
| email                   	| string       	| NOT NULL          	|
| encrypted_password      	| string       	| NOT NULL          	|

### Association

- has_many :exams
- has_many :questions
- has_many :results

## exams テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| title                   	| string      	| NOT NULL          	|
| message                 	| text        	| NOT NULL          	|
| id_digest               	| string      	|                   	|
| status                  	| integer     	| default: 1, NOT NULL|
| user_id                 	| references   	| foreign_key: true 	|

### Association

- belongs_to :user
- has_many :results
- has_many :exam_questions
- has_many :questions, through: :exam_questions

## exam_questions テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| exam_id                 	| references   	| foreign_key: true 	|
| question_id             	| references   	| foreign_key: true 	|

### Association

- belongs_to :exam
- belongs_to :question

## questions テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| content                 	| string       	| NOT NULL          	|
| allocation_id             | integer   	  | NOT NULL 	          |
| image                   	|               | ActiveStorage     	|
| user_id                 	| references   	| foreign_key: true 	|

### Association

- belongs_to :user
- has_many :choices
- has_many :exam_questions
- has_many :exams, through: :exam_questions

## choices テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| text                    	| string       	| NOT NULL          	|
| answer_id                	| integer      	| NOT NULL          	|
| question_id             	| references   	| foreign_key: true 	|

### Association

- belongs_to :question
- has_many :result_choices
- has_many :results, through: :result_choices

## result_choices テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| result_id               	| references   	| foreign_key: true 	|
| choice_id               	| references   	| foreign_key: true 	|

### Association

- belongs_to :choice
- belongs_to :result

## results テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| user_id                 	| references   	| foreign_key: true 	|
| exam_id                 	| references   	| foreign_key: true 	|

### Association

- belongs_to :user
- belongs_to :exam
- has_many :result_choices
- has_many :choices, through: :result_choices