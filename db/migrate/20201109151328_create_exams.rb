class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.integer    :open_id,  null: false
      t.string     :password, null: false
      t.references :user,     foreign_key: true
      t.timestamps
    end
  end
end