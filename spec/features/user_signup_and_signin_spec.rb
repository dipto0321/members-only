require 'rails_helper'

feature "User signup" do
  before :each do
    visit signup_path
  end

  feature "invalid signup" do
    before :each do
      fill_in "Email", with: "example@yahoo.com"
      click_on("Create User")
    end
    
    scenario "user will see flash message saying name can't be blank" do
      expect(page).to have_content("Name can't be blank")
    end

    scenario "user will still see signup page" do
      expect(page).to have_selector(:link_or_button, "Create User")
    end
    
  end

  feature "valid signup" do

    before :each do
      @name = Faker::Name.name
      fill_in "Name", with: @name

      fill_in "Email", with: Faker::Internet.email

      fill_in "Password", with: "password"

      fill_in "Password confirmation", with: "password"

      click_on("Create User")
    end

    scenario "user will be redirected to his profile" do
      expect(page).to have_content(@name)
    end

    scenario "user will be able to see post authors when he/she visits Posts index" do
      click_on("Posts")
      expect(page).to have_content(Post.last.user.name)
    end

  end
end

feature "User sign in" do

  before :each do
    @new_user = FactoryBot.create(:user)
    visit signin_path
    fill_in "Email", with: @new_user.email
    fill_in "Password", with: "password"
    click_on("Sign In")
  end

  scenario "user successfully signs in gets redirected to his/her profile" do
    expect(page).to have_content(@new_user.name)
  end

  scenario "user's successful signup will show flash[:success]" do
    expect(page).to have_content("#{@new_user.name} sign in")
  end

  scenario "user will see link to Account" do
    expect(page).to have_selector(:link_or_button, "Account")
  end

  scenario "user will see link to Profile when he/she clicks on Account" do
    click_on("Account")
    expect(page).to have_selector(:link_or_button, "Profile")
  end

  scenario "user will see button to create post" do
    expect(page).to have_selector(:link_or_button, "Create Post")
  end

  scenario "user will be able to now see posts' authors when he/she visits post index" do
    click_on("Posts")
    expect(page).to have_content(Post.last.user.name)
  end

end