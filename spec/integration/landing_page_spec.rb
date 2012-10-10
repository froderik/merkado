require 'spec_helper'

feature 'as a user I would like a landing page' do
  scenario 'visit root - find site name' do
    visit '/'
    page.should have_content('merkado')
  end
end