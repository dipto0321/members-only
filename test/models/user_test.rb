require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name:"William",email:"will@gmail.com",password:"password",password_confirmation:"password")

    @another_user = User.new(name:"August",email:"will@gmail.com",password:"password",password_confirmation:"password")
  end

  test 'name should be present' do
    @user.name = ""
    assert_not @user.valid?
    @user.name = "Edward"
    assert @user.valid?
  end

  test 'email should be present' do
   @user.email = ""
    assert_not @user.valid?
   @user.email = "edward@gmail.com"
    assert @user.valid?
  end
end
