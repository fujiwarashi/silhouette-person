class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string     :title,    null: false
      t.text       :message,  null: false
      t.references :user,     foreign_key: true
      t.timestamps
    end
  end
end