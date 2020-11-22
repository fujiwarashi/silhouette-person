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
	https://user-images.githubusercontent.com/72442462/99904331-82f74500-2d0d-11eb-96ab-be50e7e3fa43.gif

	![ダウンロード](https://user-images.githubusercontent.com/72442462/99904416-fd27c980-2d0d-11eb-8a45-bb74afb25afc.gif)


## 実装予定の機能
- 希望者へは受験終了時にメール自動送信機能
- ジャンルを設けて公開試験にタグ機能
- 非公開ユーザー向けにURLのQRコード発行機能

## データベース設計
	<!-- ER図等を添付しましょう。 -->
  

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