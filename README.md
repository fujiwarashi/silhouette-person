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
| open_id                 	| integer      	| NOT NULL          	|
| encrypted_password      	| string       	|                   	|
| user_id                 	| references   	| foreign_key: true 	|

### Association

- belongs_to :user
- has_many :results
- has_many :exam_questions
- has_many :questions, through: exam_questions

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
| image                   	|               | ActiveStorage     	|
| user_id                 	| references   	| foreign_key: true 	|

### Association

- belongs_to :user
- has_many :choices
- has_many :exam_questions
- has_many :exams, through: exam_questions

## choices テーブル

| Column                    | Type          | Options             |
| ------------------------- | ------------- | ------------------- |
| text                    	| string       	| NOT NULL          	|
| is_answer               	| boolean      	| NOT NULL          	|
| question_id             	| references   	| foreign_key: true 	|

### Association

- belongs_to :question
- has_many :result_choices
- has_many :results, through: result_choices

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
- has_many :choices, through: result_choices