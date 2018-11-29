require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = Post.new(title:"Title",content:"It's all so cool", user_id: @user.id)
  end

  test 'post should have a title' do
    @post.title = ""
    assert_not @post.valid?
    @post.title = "What's UP!!!!"
    assert @post.valid?
  end

  test 'post should have content' do
    @post.content = ""
    assert_not @post.valid?
    @post.content = "some content here"
    assert @post.valid?
  end

  test 'post can only be created by a valid user' do
    @another_post = Post.new(title:"Cool",content:"Not so cool")
    assert_not @another_post.valid?
  end
end
