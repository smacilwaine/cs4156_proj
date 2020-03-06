class CreateLectures < ActiveRecord::Migration[5.2]
  def change
    create_table :lectures do |t|
      t.string :instructor
      t.string :student
      t.string :lec_id
      t.boolean :active

      t.timestamps
    end
  end
end
