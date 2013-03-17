### UTILITY METHODS ###

def create_visitor(role = :user)
  @visitor ||= { :name => "Cucumber", :email => "example@example.com",
    :password => "cucumber", :password_confirmation => "cucumber", :role=> role }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end


def create_user(role = :user)
  create_visitor(role)
  delete_user
  @user = FactoryGirl.create(:cuc_user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged as user$/ do
  create_user(:user)
  sign_in
end

Given /^I am logged as admin$/ do
  create_user(:admin)
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

### WHEN ###


When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I open new user page$/ do
  visit '/users/new'
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I open my edit page$/ do
  visit edit_user_path(@user)
end

When /^I open other user edit page$/ do
  @u = FactoryGirl.create(:user)
  visit edit_user_path(@u)
end

When /^I sign in with a wrong name$/ do
  @visitor = @visitor.merge(:name => "wrongName")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end


When /^I create ad$/ do
  visit '/ads/new'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Sign out"
  page.should_not have_content "Sign in"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid name or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see sign up form$/ do
  page.should have_content "New user"
end

Then /^I should see an edit form$/ do
  page.should have_content "Editing user"
end

Then /^I should see change role select$/ do
  page.should have_content "Role"
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end

Then /^I should see an access denied message$/ do
  page.should have_content "Access denied"
end

Then /^I should see ad form$/ do
  page.should have_content "New ad"
end


