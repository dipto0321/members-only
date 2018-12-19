require 'rails_helper'

feature "viewing pages" do

  context 'a new user visits the app' do
    
    before :each do
      visit root_path
    end

    scenario "user will see all posts" do
      expect(page).to have_content("Read more")
    end

    scenario "user should not see authors of those posts" do
      expect(page).to_not have_content(:link_or_button, Post.last.user.name)
    end

    scenario "user will see Sign In button" do
      expect(page).to have_selector(:link_or_button, "Sign in")
    end

  end

  context 'user clicks on a post' do
    before :each do
      visit root_path
      within first("div.card") do
        click_on("Read more")
      end
    end
    
    scenario "user will go to the post's page and see the post content" do
      expect(page).to have_content(Post.last.content)
    end

    scenario "user should not be able to see the post's author" do
      expect(page).to_not have_content(Post.last.user.name)
    end

    scenario "user will see Add Comment" do
      expect(page).to have_selector(:link_or_button, "Comment")
    end

    scenario "if there are any comments, user will see those comments" do
      expect(page).to have_content(Post.last.comments.first.body)
    end

  end

end