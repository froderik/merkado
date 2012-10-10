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
      # capybara seems broken when it comes to following redirects
      # digging up the driver in this way works though!
      page.driver.response.body.should =~ /Invalid user/
    end
  end
end