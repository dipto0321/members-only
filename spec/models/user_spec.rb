require 'rails_helper'

describe 'User' do

  context "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
  
  context "validations" do
    before :each do
      @user = FactoryBot.build(:user)
    end

    it "is valid with name, email and password/password-confirmation" do
      expect(@user).to be_valid
    end
    it "is invalid without name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end
    
    it "is invalid without email" do
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end
  end

  context "User.new_token" do
    it "returns a random generated string" do
      str1 = User.new_token
      str2 = User.new_token
      expect(str1).to_not eq(str2)
    end
  end

  context "User.digest" do
    it "returns a hashed version of a passed string" do
      str = "password"
      expect(User.digest(str)).to eq(str)
    end
  end

  context "User.find_select_user" do
    it "returns the user based on id passed" do
      user = User.first
      expect(User.find_select_user(user.id)).to eq(user)
    end
  end
end