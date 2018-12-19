require 'rails_helper'

describe "Post" do

  context "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  context "validations" do
    before :each do
      @post = FactoryBot.build(:post)
    end

    it "is valid with title and content" do
      @post.valid?
      expect(@post).to be_valid
    end

    it "is invalid without a title" do
      @post.title = nil
      @post.valid?
      expect(@post.errors[:title]).to include("can't be blank")
    end

    it "is invalid without content" do
      @post.content = nil
      @post.valid?
      expect(@post.errors[:content]).to include("can't be blank")
    end
  end

  context "post_created instance method" do
    it "returns a string version of the post's created date" do
      post = FactoryBot.build(:post)
      expect(post.post_created).to eq(Time.now.localtime.to_s.gsub(/.\+.{4}/,''))
    end
  end

  context "Post.all_posts" do
    it "returns an array of all posts but only with id, title, user_id and content" do
      expect(Post.all_posts.map {|post| [post.id, post.title, post.content, post.user_id]}).to match_array(Post.all.map {|post| [post.id, post.title, post.content, post.user_id]})
    end

  end
end