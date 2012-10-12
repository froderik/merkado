def create_identity email, password
  identity = Identity.new
  identity.email = email
  identity.password = password
  CouchPotato.database.save_document identity
  identity
end

def create_user email, password
  create_identity email, password
  user = User.new
  user.email = email
  CouchPotato.database.save_document user
  user
end

def sign_in email, password
  visit '/'
  within '#credentials' do
    fill_in 'auth_key', :with => email
    fill_in 'password', :with => password
    click_on 'Sign in'
  end
end

def create_and_sign_in_user email = 'default@example.com', password ='d3fau1t'
  user = create_user email, password
  sign_in email, password
  user
end
