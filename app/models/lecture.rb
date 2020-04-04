class Lecture < ApplicationRecord
    # Associations
    belongs_to :instructor, :class_name => 'User', :validate => true
    belongs_to :student, :class_name => 'User', :validate => true

    # Validation
    # Active
    validates :active, :presence => true, :inclusion => [ true, false ]
end
