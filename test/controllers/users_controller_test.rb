require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "unlogged user can't open user edit" do
    get edit_user_path(@user1)
    assert_not flash.empty?
    assert_redirected_to signin_path
  end

  test "logged in user should be able to edit his own profile" do
    sign_in_as(@user1)
    get edit_user_path(@user1)
    assert_template 'users/edit'
  end
end
