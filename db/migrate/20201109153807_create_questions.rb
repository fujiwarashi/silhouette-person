class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string     :content,       null: false
      t.references :user,          null: false, foreign_key: true
      t.integer    :allocation_id, null: false
      t.timestamps
    end
  end
end
