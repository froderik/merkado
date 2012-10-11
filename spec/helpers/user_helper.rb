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
