class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string     :title,    null: false
      t.text       :message,  null: false
      t.string     :id_digest
      t.integer    :status,   null: false, default: 1
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end