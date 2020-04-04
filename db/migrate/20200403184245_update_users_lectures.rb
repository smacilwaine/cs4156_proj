class UpdateUsersLectures < ActiveRecord::Migration[5.2]
  def change
    # Lectures

    # Drop instructor and student string columns
    remove_column :lectures, :instructor, :type => :string
    remove_column :lectures, :student, :type => :string

    # Drop lec_id and use inbuilt id as primary key
    remove_column :lectures, :lec_id, :type => :string

    # Add columns in lectures
    add_column :lectures, :instructor_id, :bigint, :null => false
    add_column :lectures, :student_id, :bigint, :null => false

    # Add foreign key to users
    add_foreign_key :lectures, :users, :column => :instructor_id, :on_delete => :cascade
    add_foreign_key :lectures, :users, :column => :student_id, :on_delete => :cascade

    # Users
    change_column :users, :username, :string, :null => false
    change_column :users, :email, :string, :null => false
  end
end
