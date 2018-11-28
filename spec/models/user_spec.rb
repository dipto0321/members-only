require 'rails_helper'

RSpec.describe User, type: :model do
 
  before do
    @user = User.new
 end

  it "needs to have name and email present" do
     @user.name = ""
     @user.email = ""
     @user.password = "password"
     @user.password_confirmation = "password"
     expect(@user.save).not_to be_successful
  end
end
