class CreateResultChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :result_choices do |t|
      t.references :result, foreign_key: true
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
