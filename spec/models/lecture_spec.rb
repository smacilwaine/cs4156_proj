require 'rails_helper'

# Controller's 
# Allow only Instructors to create a Lecture and disallow Students from creating a Lecture
# Disallow Instructors to add themselves maliciously
# E.g. :instructor_id => 1, :student_id => 1
RSpec.describe Lecture, :type => :model do
    fixtures :users
    before :each do
        @ins_1 = users(:instructor_one)
        @ins_2 = users(:instructor_two)
        @st_1 = users(:student_one)
        @st_2 = users(:student_two)
    end
    context "When testing the association between 'User' and 'Lecture'" do
        

        # def add_user_records
        #     users = [@ins_1, @ins_2, @st_1, @st_2]
        #     users.each do
        #         |user|
        #         user = User.new(:username => user[:username], :password => user[:password_digest], :password_confirmation => user[:password_digest], :role => user[:role], :email => user[:email], :email_confirmation => user[:email])
        #         expect( user.valid? ).to eq false
        #         user.errors.each do
        #             |k, v|
        #             puts k, v
        #         end

        #         expect( user.errors ).to include "nadu"
        #     end
        # end

        def valid_lecture? lecture, outcome
            expect( lecture.valid? ).to eq outcome
            if outcome 
                expect( lecture.errors.messages ).to be_empty
            else
                expect( lecture.errors.messages ).not_to be_empty
            end
            expect( lecture.save ).to eq outcome
        end

        it "should allow an 'Instructor' and a 'Student' to be added to the Lecture" do
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => true)
            valid_lecture? lecture, true
        end
        it "should not allow an 'Instructor' and another 'Instructor' to be added to the Lecture" do
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @ins_2[:id], :active => true)
            valid_lecture? lecture, false
        end
        it "should allow an 'Instructor' to add multiple 'Student's to the Lecture" do
            lecture_first = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => true)
            valid_lecture? lecture_first, true
            lecture_second = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_2[:id], :active => true)
            valid_lecture? lecture_second, true
        end
    end

    context "When testing the 'active'" do
        before :each do
            @blank = "can't be blank"
            @not_in_list = "is not included in the list"
        end

        def valid_active? active, error_message
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => active)
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
            lecture = Lecture.new(:instructor_id => @ins_1[:id], :student_id => @st_1[:id], :active => active)
            expect( lecture.valid? ).to eq true
            expect( lecture.errors.messages[:active] ).to be_empty
        end
    end
end