require 'rails_helper'

RSpec.describe User, :type => :model do
    context "When testing the 'username'" do
        before :each do
            @blank = "can't be blank"
            @too_short = "is too short (minimum is 8 characters)"
            @too_long = "is too long (maximum is 64 characters)"
            @not_unique = "has already been taken"
        end

        def valid_username? username, error_message
            user = User.new(:username => username)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:username] ).to include error_message
        end

        it "should be present" do
            username = ''
            valid_username? username, @blank
        end
        it "should not accept less than 8 characters" do
            username = 'brock'
            valid_username? username, @too_short
        end
        it "should not accept more than 64 characters" do
            # Creates a random string of 80 characters
            username = (0...8).map { (65 + rand(26)).chr }.join * 10
            valid_username? username, @too_long
        end
        it "should be unique" do
            username = 'brock123'
            user_valid = User.create(:username => username, :password => 'brock123', :password_confirmation => 'brock123', :role => 'Instructor', :email => 'b@b.com', :email_confirmation => 'b@b.com')
            expect( user_valid.valid? ).to eq true
            # Try to create another user with the same username
            valid_username? username, @not_unique
        end
        it "should be case sensitive" do
            username = 'brock123'
            user_lower = User.create(:username => username, :password => 'brock123', :password_confirmation => 'brock123', :role => 'Instructor', :email => 'b@b.com', :email_confirmation => 'b@b.com')
            # Try to create another user with different case of same username
            user_upper = User.create(:username => username.upcase, :password => 'brock123', :password_confirmation => 'brock123', :role => 'Instructor', :email => 'g@g.com', :email_confirmation => 'g@g.com')
            expect( user_lower.valid? ).to eq true
            expect( user_upper.valid? ).to eq true
        end
    end

    context "When testing the 'password'" do
        before :each do
            @blank = "can't be blank"
            @too_short = "is too short (minimum is 8 characters)"
            @too_long = "is too long (maximum is 64 characters)"
        end

        def valid_password? password, error_message
            user = User.new(:password => password)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:password] ).to include error_message
        end

        it "should be present" do
            password = ''
            valid_password? password, @blank
        end
        it "should not accept less than 8 characters" do
            password = 'short'
            valid_password? password, @too_short
        end
        it "should not accept more than 64 characters" do
            # Creates a random string of 80 characters
            password = (0...8).map { (65 + rand(26)).chr }.join * 10
            valid_password? password, @too_long
        end
    end

    context "When testing the 'password confirmation'" do
        before :each do
            @blank = "can't be blank"
            @match_fail = "doesn't match Password"
        end

        def valid_password_confirmation? password, password_confirmation, error_message
            user = User.new(:password => password, :password_confirmation => password_confirmation)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:password_confirmation] ).to include error_message
        end

        it "should be present" do
            password = 'testing@123'
            password_confirmation = ''
            valid_password_confirmation? password, password_confirmation, @blank
        end
        it "should match the password" do
            password = 'testing@123'
            password_confirmation = 'testing'
            # No match
            valid_password_confirmation? password, password_confirmation, @match_fail
            # Match
            user = User.new(:password => password, :password_confirmation => password)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:password_confirmation] ).to be_empty
        end

    end

    context "When testing the 'role'" do
        before :each do
            @blank = "can't be blank"
            @not_in_list = "is not included in the list"
        end

        def valid_role? role, error_message
            user = User.new(:role => role)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:role] ).to include error_message
        end

        it "should be present" do
            role = ''
            valid_role? role, @blank
        end
        it "should be present in the list" do
            # Not in the list
            role = 'teacher'
            valid_role? role, @not_in_list
            # In the list
            role = "Teaching Assistant"
            user = User.new(:role => role)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:role] ).to be_empty
        end
    end

    context "When testing the 'email'" do
        before :each do
            @blank = "can't be blank"
            @invalid_format = "is invalid"
            @not_unique = "has already been taken"
        end

        def valid_email? email, error_message
            user = User.new(:email => email)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:email] ).to include error_message
        end

        it "should be present" do
            email = ''
            valid_email? email, @blank
        end
        it "should have the correct format" do
            # Source - https://en.wikipedia.org/wiki/Email_address#Examples
            invalid_emails = [
                # This is accepted even though it is mentioned as invalid in Wikipedia
                # '1234567890123456789012345678901234567890123456789012345678901234+x@example.com',
                'Abc.example.com',
                'A@b@c@example.com',
                'a"b(c)d,e:f;g<h>i[j\k]l@example.com',
                'just"not"right@example.com',
                'this is"not\allowed@example.com',
                'this\ still\"not\allowed@example.com',
                '@gmail.com',
                'someone@',
                '@'
            ]
            invalid_emails.each do
                |email|
                valid_email? email, @invalid_format
            end

            valid_emails = [
                # These are not accepted even though it is mentioned as valid in Wikipedia
                # '" "@example.org',
                # '"john..doe"@example.org',
                'simple@example.com',
                'very.common@example.com',
                'disposable.style.email.with+symbol@example.com',
                'other.email-with-hyphen@example.com',
                'fully-qualified-domain@example.com',
                'user.name+tag+sorting@example.com',
                'x@example.com',
                'example-indeed@strange-example.com',
                'admin@mailserver1',
                'example@s.example',
                'mailhost!username@example.org',
                'user%example.com@example.org'
            ]
            valid_emails.each do
                |email|
                user = User.new(:email => email)
                expect( user.valid? ).to eq false
                expect( user.errors.messages[:email] ).to be_empty
            end
        end
        it "should be unique" do
            email = 'brock21@gmail.com'
            user_valid = User.create(:username => 'brock123', :password => 'brock123', :password_confirmation => 'brock123', :role => 'Instructor', :email => email, :email_confirmation => email)
            valid_email? email, @not_unique
        end
        it "should not be case sensitive" do
            email = 'brock21@gmail.com'
            user_valid = User.create(:username => 'brock123', :password => 'brock123', :password_confirmation => 'brock123', :role => 'Instructor', :email => email, :email_confirmation => email)
            valid_email? email.upcase, @not_unique
        end
    end

    context "When testing the 'email confirmation'" do
        before :each do
            @blank = "can't be blank"
            @match_fail = "doesn't match Email"
        end

        def valid_email_confirmation? email, email_confirmation, error_message
            user = User.new(:email => email, :email_confirmation => email_confirmation)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:email_confirmation] ).to include error_message
        end

        it "should be present" do
            email = 'brock21@gmail.com'
            email_confirmation = ''
            valid_email_confirmation? email, email_confirmation, @blank
        end
        it "should match the email" do
            email = 'brock21@gmail.com'
            email_confirmation = 'bryce25@gmail.com'
            # No match
            valid_email_confirmation? email, email_confirmation, @match_fail
            # Match
            user = User.new(:email => email, :email_confirmation => email.upcase)
            expect( user.valid? ).to eq false
            expect( user.errors.messages[:email_confirmation] ).to be_empty
        end
    end
end