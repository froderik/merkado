require 'spec_helper'

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

end