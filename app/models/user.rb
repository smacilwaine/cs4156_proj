class User < ApplicationRecord
    has_secure_password
    # Associations
    has_many :instructors, :class_name => 'Lecture', :foreign_key => :instructor_id
    has_many :students, :class_name => 'Lecture', :foreign_key => :student_id

    # Validation
    # Username
    validates :username, :presence => true, :length => { :in => 8..64 }, :uniqueness => { :case_sensitive => true }

    # Password
    validates :password, :presence => true, :length => { :in => 8..64 }, :if => :password_digest_changed?, :confirmation => true
    validates :password_confirmation, :presence => true

    # Role
    roles = ['Student', 'Instructor', 'Teaching Assistant']
    validates :role, :presence => true, :inclusion => roles

    # Email
    validates :email, :presence => true, :format => { :with => URI::MailTo::EMAIL_REGEXP }, :uniqueness => { :case_sensitive => false }, :confirmation => { :case_sensitive => false }
    validates :email_confirmation, :presence => true
end
