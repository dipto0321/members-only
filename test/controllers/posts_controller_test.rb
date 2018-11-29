require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
    sign_in_as(@user1)
    post user_posts_path(@user1), params: {
      post: {
        user_id: @user1.id,
        title: "I hate testing",
        content: "It's all cool"
      }
    }
    @post1 = @user1.posts.last
  end

  test 'an unlogged user cannot access new post form' do
    assert current_user
    sign_out
    assert_nil current_user
    get new_user_post_path(@user2)
    
  end

  test 'logged users can create new post' do
    sign_in_as(@user1)
    assert current_user
    get new_user_post_path(@user1)
    assert_template 'posts/new'
    post user_posts_path(@user1), params: {
      post: {
        user_id: @user1.id,
        title: "It's all cool",
        content: "Whataaaap"
      }
    }

    @post2 = @user1.posts.last

    assert_redirected_to user_post_path(@user1,@post2)

    assert_match flash[:success], "Post created!"
  end

  test 'user can only edit his/her own post' do
    sign_in_as(@user2)
    get edit_user_post_path(@user1,@post1)
    assert_match flash[:danger], "You are not authorized to do that."
  end
end
