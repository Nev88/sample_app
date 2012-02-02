require 'spec_helper'

describe "FollowUnfollows" do
 it "should have follow/unfollow links" do
   @user=Factory(:user)
   integration_sign_in(@user)
   @other_user=Factory(:user, :email => Factory.next(:email))
   visit user_path(@other_user)
   response.should have_selector("input", :value => "Follow")
   click_button
   response.should have_selector("input", :value => "Unfollow")
 end
end
