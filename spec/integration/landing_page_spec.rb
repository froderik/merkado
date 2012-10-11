require 'spec_helper'

def create_user email, password
  user = User.new
  user.email = email
  user.password = password
  CouchPotato.database.save_document user
end

def sign_in email, password
  visit '/'
  within '#credentials' do
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_on 'Sign in'
  end
end

def create_and_sign_in_user email = 'default@example.com', password ='d3fau1t'
  create_user email, password
  sign_in email, password
end

feature 'as a user I would like a landing page' do
  scenario 'visit root - find site name' do
    visit '/'
    page.should have_content('merkado')
    page.should_not have_content('Sign out')
  end

  scenario 'sign in with nonexisting user' do
    sign_in 'finns.inte@example.com', ''
    page.should have_content 'Invalid user'
  end

  scenario 'sign in with existing user' do
    create_and_sign_in_user
    page.should have_content 'Available order books'
  end

  scenario 'sign out' do
    create_and_sign_in_user
    page.should have_content('Sign out')
    click_on 'Sign out'
    page.should_not have_content('Sign out')
  end
end