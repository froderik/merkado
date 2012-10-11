require 'spec_helper'

def create_user email, password
  user = User.new
  user.email = email
  user.password = password
  CouchPotato.database.save_document user
end

feature 'as a user I would like a landing page' do
  scenario 'visit root - find site name' do
    visit '/'
    page.should have_content('merkado')
  end

  scenario 'sign in with nonexisting user' do
    visit '/'
    within '#credentials' do
      fill_in 'email', :with => 'finns.inte@example.com'
      fill_in 'password', :with => ''
      click_on 'Sign in'
    end
    page.should have_content 'Invalid user'
  end

  scenario 'sign in with existing user' do
    create_user 'foo.bar@example.com', 'trickypassword'
    visit '/'
    within '#credentials' do
      fill_in 'email', :with => 'foo.bar@example.com'
      fill_in 'password', :with => 'trickypassword'
      click_on 'Sign in'
    end
    page.should have_content 'Available order books'
  end
end