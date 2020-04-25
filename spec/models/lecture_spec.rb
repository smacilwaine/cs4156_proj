require 'rails_helper'

# Controller's 
# Allow only Instructors to create a Lecture and disallow Students from creating a Lecture
# Disallow Instructors to add themselves maliciously
# E.g. :instructor_id => 1, :student_id => 1
RSpec.describe Lecture, :type => :model do
    fixtures :users
    context "When testing the association between 'User' and 'Lecture'" do
        before :each do
            @ins_1 = users(:instructor_one)
            @ins_2 = users(:instructor_two)
            @st_1 = users(:student_one)
            @st_2 = users(:student_two)
        end

        def valid_lecture? lecture
            expect( lecture.valid? ).to eq true
            expect( lecture.save ).to eq true
        end

        it "should allow an 'Instructor' and a 'Student' to be added to the Lecture" do
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => true)
            valid_lecture? lecture
        end
        it "should allow an 'Instructor' and another 'Instructor' to be added to the Lecture" do
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @ins_2[:id], :active => true)
            valid_lecture? lecture
        end
        it "should allow an 'Instructor' to add multiple 'Student's to the Lecture" do
            lecture_first = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => true)
            valid_lecture? lecture_first
            lecture_second = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_2[:id], :active => true)
            valid_lecture? lecture_second
        end
    end

    context "When testing the 'active'" do
        before :each do
            @blank = "can't be blank"
            @not_in_list = "is not included in the list"
        end

        def valid_active? active, error_message
            lecture = Lecture.new(:active => active)
            expect( lecture.valid? ).to eq false
            expect( lecture.errors.messages[:active] ).to include error_message
        end

        it "should not be blank" do
            active = ''
            valid_active? active, @blank
        end
        it "should be present in the list" do
            # Not in the list
            active = nil
            valid_active? active, @not_in_list
            # In the list
            active = true
            lecture = Lecture.new(:active => active)
            expect( lecture.valid? ).to eq false
            expect( lecture.errors.messages[:active] ).to be_empty
        end
    end
end