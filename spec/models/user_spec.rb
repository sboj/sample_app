require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name =>""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email = User.new(@attr.merge(:email => ""))
    no_email.should_not be_valid
  end
  
  it "should reject long name" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE@hoo.bar.com first.last@fdslk.ca]
    addresses.each do |a|
      valid_email_user = User.new(@attr.merge(:email => a))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@for,adk user@l user iser@fds.]
    addresses.each do |a|
      invalid_email_user = User.new(@attr.merge(:email => a))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user = User.new(@attr)
    user.should_not be_valid
  end
  
  it "should reject email address identical up to case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user = User.new(@attr)
    user.should_not be_valid
  end  
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
      User.new(@attr).should respond_to(:password)
    end
    
    it "shoud have a password confirmation attribute" do
      User.new(@attr).should respond_to(:password_confirmation)
    end
    
  end
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
        
    describe "password encryption" do
      
      before (:each) do
        @user = User.create!(@attr)
      end
      
      it "should have an encrpted password attribute" do
        @user.should respond_to(:encrypted_password)
      end
      
    end
  end
  
  
end
