require "rails_helper"

RSpec.describe "Logging In", type: :feature do
  it "can log in with valid credentials" do
    Campaign.create(name: "Turing West Marches", status: "active")
    user = User.create(username: "funbucket13",
                       password: "test",
                       email: "bucket@example.com")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq("/login")

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq("/")

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Register")
    expect(page).to_not have_link("I already have an account")

    click_on "Log Out"

    expect(current_path).to eq root_path
    expect(page).to have_content("You have successfully logged out.")
  end
end
