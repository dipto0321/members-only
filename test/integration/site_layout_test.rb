require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:michael)
    @post1 = posts(:first_post)
  end

  test 'home page links when logged out' do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", user_path(@user1), count: 0
    assert_select "a[href=?]", user_post_path(@post1.user_id,@post1.id)
  end
end
