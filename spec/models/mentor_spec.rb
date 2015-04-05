require 'rails_helper'

RSpec.describe Mentor, :type => :model do
 	it{should belong_to(:mentee).class_name('User').with_foreign_key('mentee_id')}
 	it{should belong_to(:mentoring).class_name('User').with_foreign_key('mentor_id')}
 	before{100.times{FactoryGirl.create(:user)}}

 	it "can get users" do
	    FactoryGirl.create(:user).should be_valid
  	end

 	context "#choose_mentor" do
 		
 		it "Should choose a valid person to mentor" do
 			create = User.create!(email: "hellowerd2@gmail.com", password: "Somethingwierd12",password_confirmation: "Somethingwierd12", first_name: "Hello",last_name: "world", mentor: true, primary_industry: "Technology", stage_of_career: 5, mentor_industry: "Technology", peer_industry: ["Business", "Technology", "Startup"].sample, current_goal: ["Rising the ranks / breaking the glass ceiling","Switching industries","Finding work/life balance"].sample,top_3_interests: ["Arts", "Music", "Crafting", "Home improvement / Decorating", "Being a mom", "Dogs", "Cats", "Watching Sports", "Outdoors / Hiking", "Exercise", "Biking", "Yoga", "Running", "Beer","Wine","Traveling"," Local events",    "Reading", "Photography", "Movies","Cooking / Eating / Being a foodie" ,"Social issues / volunteering","Video Games"].sample(3), live_in_detroit: %w(true false).sample, is_participating_next_month: true, is_participating_this_month: true,
 				mentor_times: 1)
 			mentee = User.where(is_participating_this_month:true, waitlist: false, primary_industry: "Technology").sample
 			mentor_session = Mentor.create(mentee_id: mentee.id, question: "Hello")
 			mentor = mentor_session.mentoring
 			expect(mentor_session).to be_an_instance_of(Mentor)
 			expect(User.all.count).to eq(101)
 			expect(mentor).to be_an_instance_of(User)
 			expect(mentor.stage_of_career).to be(5)
 			expect(mentor.mentor_industry).to eq("Technology")
 			expect(mentor.waitlist).to be(false)
 		end

 		it "Should give a mentor of 5 if the user is 5 and is not themselves" do
 			user = User.create!(email: "hello2@gmail.com", password: "Somethingwierd12",password_confirmation: "Somethingwierd12", first_name: "Hello",last_name: "world", mentor: true, primary_industry: "Technology", stage_of_career: 5, mentor_industry: "Technology", peer_industry: ["Business", "Technology", "Startup"].sample, current_goal: ["Rising the ranks / breaking the glass ceiling","Switching industries","Finding work/life balance"].sample,top_3_interests: ["Arts", "Music", "Crafting", "Home improvement / Decorating", "Being a mom", "Dogs", "Cats", "Watching Sports", "Outdoors / Hiking", "Exercise", "Biking", "Yoga", "Running", "Beer","Wine","Traveling"," Local events",    "Reading", "Photography", "Movies","Cooking / Eating / Being a foodie" ,"Social issues / volunteering","Video Games"].sample(3), live_in_detroit: %w(true false).sample, is_participating_next_month: true, is_participating_this_month: true,
 				mentor_times: 1)
 			user2 = User.create!(email: "hellowerd2@gmail.com", password: "Somethingwierd12",password_confirmation: "Somethingwierd12", first_name: "Hello",last_name: "world", mentor: true, primary_industry: "Technology", stage_of_career: 5, mentor_industry: "Technology", peer_industry: ["Business", "Technology", "Startup"].sample, current_goal: ["Rising the ranks / breaking the glass ceiling","Switching industries","Finding work/life balance"].sample,top_3_interests: ["Arts", "Music", "Crafting", "Home improvement / Decorating", "Being a mom", "Dogs", "Cats", "Watching Sports", "Outdoors / Hiking", "Exercise", "Biking", "Yoga", "Running", "Beer","Wine","Traveling"," Local events",    "Reading", "Photography", "Movies","Cooking / Eating / Being a foodie" ,"Social issues / volunteering","Video Games"].sample(3), live_in_detroit: %w(true false).sample, is_participating_next_month: true, is_participating_this_month: true,
 				mentor_times: 1)
 			mentee = User.where(is_participating_this_month:true, waitlist: false, primary_industry: "Technology").sample
 			mentor_session = Mentor.create(mentee_id: user.id, question: "Hello")
 			mentor = mentor_session.mentoring
 			expect(mentor_session).to be_an_instance_of(Mentor)
 			expect(User.all.count).to eq(102)
 			expect(mentor).to be_an_instance_of(User)
 			expect(mentor).to eq(user2)
 		end

 		it "Should return error if invaid user" do
 			mentee = User.where(is_participating_this_month:true, waitlist: false, primary_industry: "Technology").sample
 			expect{Mentor.create(mentee_id: mentee.id, question: "Hello")}.to raise_error("We don't have mentors for you at this time")
 		end
 	end

end
