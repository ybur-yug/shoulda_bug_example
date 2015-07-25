require "rails_helper"

def create_list(name)
  visit lists_path
  click_on "new list"
  fill_in "Name", with: name
  click_on "Create List"
  visit lists_path
end

def create_task(list_name, description)
  click_on list_name
  click_on "add a task"
  fill_in "Description", with: "get groceries"
  click_on "Create Task"
end

context "integration process", js: true do
  describe ".create", type: :feature do
    it "adds a new list properly" do
      create_list("todos")
      expect(page).to have_content "todos"
    end

    it "errors with no list name entered" do
      visit lists_path
      click_on "new list"
      click_on "Create List"
      expect(page).to have_content "Errors, try again"
    end

    it "can create a task for a list" do
      create_list("todows")
      click_on "todows"
      click_on "add a task"
      fill_in "Description", with: "get groceries"
      click_on "Create Task"
      expect(page).to have_content "get groceries"
    end

    it "errors with no task name entered" do
      create_list("stuffthings")
      click_on "stuffthings"
      click_on "add a task"
      click_on "Create Task"
      expect(page).to have_content "Errors, try again"
    end
  end

  describe ".edit", type: :feature do
    it "can edit a list" do
      create_list("todeezys")
      click_on "todeezys"
      click_on "edit list"
      fill_in "Name", with: "todonts"
      click_on "Update List"
      expect(page).to have_content "todonts"
    end

    it "can edit a task for a list" do
      create_list("todeezles")
      create_task("todeezles", "do things")
      click_on "edit_task"
      fill_in "Description", with: "do stuff"
      click_on "Update Task"
      expect(page).to have_content "do stuff"
    end
  end

  describe ".destroy", type: :feature do
    it "can delete a list" do
      create_list("stuff")
      click_on "stuffyz"
      click_on "delete list"
      page.driver.browser.switch_to.alert.accept
      expect(page.has_text?("stuffyz")).to eq false
    end

    it "can delete a task" do
      create_list("stuff")
      create_task("stuff", "do shit")
      click_on "delete task"
      page.driver.browser.switch_to.alert.accept
      expect(page.has_text?("do shit")).to eq false
    end
  end
end
