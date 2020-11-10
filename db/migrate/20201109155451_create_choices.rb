class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.string     :text,      null: false
      t.integer    :answer_id, null: false
      t.references :question,  foreign_key: true
      t.timestamps
    end
  end
end
