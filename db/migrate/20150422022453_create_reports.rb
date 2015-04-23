class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :student_nfl_id
      t.integer :tutor_nfl_id
      t.text :what_was_covered
      t.text :performance
      t.text :assignment
      t.boolean :director_flag
      t.boolean :parent_flag
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
