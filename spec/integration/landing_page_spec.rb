require 'spec_helper'

feature 'as a user I would like a landing page: ' do
  scenario 'visit root - find site name' do
    visit '/'

    page.should have_content 'merkado'
    page.should_not have_content 'Sign out'
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
    page.should have_content 'Sign out'

    click_on 'Sign out'
    page.should_not have_content 'Sign out'
  end

  scenario 'honor password' do
    email = 'a.user@exmple.com'
    create_user email, 'lousy'

    sign_in email, 'anotherpassword'

    page.should have_content 'Invalid user'
  end
end