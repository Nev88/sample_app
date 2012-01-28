require 'spec_helper'

describe PagesController do
  render_views
  
  before (:each) do
    @base_title="Ruby on Rails Tutorial Sample App"
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end 
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                    :content => @base_title + " | Home")
    end
    
    describe "for signed-in users" do
      before(:each) do
        @user=Factory(:user)
        test_sign_in(@user)
        mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")   
      end
      it "should have '1 micropost' in sidebar" do
        get 'home'
        response.should have_selector("span", :content => "1 micropost")
      end
      
      it "should have '2 microposts' in sidebar" do
        mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
        get 'home'
        response.should have_selector("span", :content => "2 microposts")
      end
      
      it "should paginate microposts" do
      35.times do
         Factory(:micropost, :user => @user, :content => "Content")
      end
      get :home
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/?page=2",
                                                            :content => "2")
      response.should have_selector("a", :href => "/?page=2",
                                           :content => "Next")
      end 
      
     # describe "delete link" do
     #   before(:each) do
     #     test_sign_in(@user)
     #     @another_user=Factory(:user, :email => "another_user@bk.ru")
     #     Factory(:micropost, :user => @user, :content => "Foo bar")
     #     Factory(:micropost, :user => @another_user, :content => "Baz quux")
     #     !!!!!!ÏÎÄÏÈÑÀÒÜ ÍÀ FEED another_user!!!!!!
     #   end
     # 
     #  it "should have for self micropost" do 
     #     get :home
     #     response.should have_selector("a", :href => "/microposts/1",
     #                                :title => "Foo bar", :content => "delete")
     #   end
     # 
     #  it "should not have  for another user micropost" do 
     #     get :home
     #     response.should_not have_selector("a", :href => "/microposts/2",
     #                               :title => "Baz quux", :content => "delete")
     #   end
     # end
      
    end
    
  end  

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
    response.should have_selector("title",
                    :content => @base_title + " | Contact")
    end
  
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                    :content => @base_title + " | About")
    end
  
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                    :content => @base_title + " | Help")
    end
  end

  
  
end
