class Lecture < ApplicationRecord
    # Associations
    belongs_to :instructor, :class_name => 'User', :validate => true
    belongs_to :student, :class_name => 'User', :validate => true
    # Custom validation for instructor and student
    validate :is_instructor, :is_student

    def is_instructor
        if User.where(:id => instructor[:id]).take[:role] != "Instructor"
            errors.add(:instructor, "Expected instructor, got something else")
        end
    end

    def is_student
        if User.where(:id => student[:id]).take[:role] != "Student"
            errors.add(:instructor, "Expected student, got something else")
        end
    end

    # Validation
    # Active
    #validates :active, :presence => true, :inclusion => [ true, false ]
    validates :active, :inclusion => [ true, false ]
end
