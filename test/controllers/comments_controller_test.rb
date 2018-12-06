require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def test_create
    get comments_create_url
    assert_response :success
  end

end
