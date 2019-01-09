require 'rails_helper'

describe "Comment" do

  context "factories" do
    it "has a valid factory for comment on a post" do
      expect(FactoryBot.build(:comment_on_post)).to be_valid
    end
    
    it "has a valid factory for comment on another comment" do
      expect(FactoryBot.build(:comment_on_comment)).to be_valid
    end
  end

  context "default scope" do
    it "lists comments starting from the latest created one" do
      expect(Comment.first.created_at > Comment.last.created_at).to be(true)
    end
  end
end