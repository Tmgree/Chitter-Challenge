def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :username, with: 't'
  fill_in :email,    with: 'tom@example.com'
  fill_in :password, with: 'oranges!'
  fill_in :password_confirmation, with: 'oranges!'
  click_button 'Sign up'
end

def sign_up2(email: 'alice@example.com', password: '12345678', password_confirmation: '12345678', username: 't')
  visit '/users/new'
  fill_in :username, with: 't'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def sign_in(email: 'testemail@example.com', password: 'password_duh')
 User.create(email: email, username: username, password: password, password_confirmation: password)
 visit 'sessions/new'
 fill_in :username, with: username
 fill_in :email, with: email
 fill_in :password, with: password
 click_button 'Sign in'
end
