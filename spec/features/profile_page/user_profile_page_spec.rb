require "rails_helper"

RSpec.describe "As a visitor", type: :feature do
  context "when I log in on the front page" do
    it "redirects me to my profile page and I can see my characters" do
      campaign = Campaign.create(name: "Turing West Marches", status: "active")
      user1 = User.create(username: "funbucket13",
                          password: "test",
                          email: "bucket@example.com")
      user2 = User.create(username: "some_user",
                          password: "test",
                          email: "someone@example.com")
      char1 = Character.create(name:            "Cormyn",
                               race:            "Human",
                               level:           3,
                               character_class: "Ranger",
                               campaign:        campaign,
                               user:            user1)

      char2 = Character.create(name:            "Orlaq",
                               race:            "Elven",
                               level:           3,
                               character_class: "Monk",
                               campaign:        campaign,
                               user:            user1)

      char3 = Character.create(name:            "Oleander",
                               race:            "Dragonborn",
                               level:           3,
                               character_class: "Fighter",
                               campaign:        campaign,
                               user:            user2)

      visit "/"

      click_on "Log In"

      expect(current_path).to eq("/login")

      fill_in :username, with: user1.username
      fill_in :password, with: user1.password

      click_button "Log In"

      expect(current_path).to eq("/profile")
      expect(page).to have_content(campaign.name)
      expect(page).to have_content(char1.name)
      expect(page).to have_content(char2.name)
      expect(page).to_not have_content(char3.name)
    end
  end
end
