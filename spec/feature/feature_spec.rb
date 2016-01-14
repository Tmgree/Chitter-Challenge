feature 'Chitter' do
  scenario 'user is able to see list of peeps on homepage' do
   Peep.create(peep: 'test')
   visit '/'
   expect(page.status_code).to eq 200
   within 'ul#peeps' do
     expect(page).to have_content('test')
   end
 end

 feature 'creating peeps' do
  scenario 'user is allowed to create a new peep' do
    visit '/peeps/new'
    fill_in 'peep', with: 'testing123'
    click_button 'Submit'
    within 'ul#peeps' do
      expect(page).to have_content('test')
    end
  end
end

feature 'signing in' do
 scenario 'user is allowed to create a new account' do
   expect { sign_up }.to change(User, :count).by(1)
   expect(page).to have_content('Welcome, tom@example.com')
    expect(User.first.email).to eq('tom@example.com')
 end
end

scenario 'requires a matching confirmation password' do
   expect { sign_up2(password_confirmation: 'wrong') }.not_to change(User, :count)
 end

 scenario 'with a password that does not match' do
  expect { sign_up2(password_confirmation: 'wrong') }.not_to change(User, :count)
  expect(page).to have_content 'Password and confirmation password do not match'
end

scenario "I can't sign up without an email address" do
    expect { sign_up2(email: nil) }.not_to change(User, :count)
  end

  scenario 'I cannot sign up with an existing email' do
  sign_up
  expect { sign_up }.to_not change(User, :count)
  expect(page).to have_content('Email is already taken')
end

scenario 'I cannot sign up without an email address' do
  expect { sign_up2(email: nil) }.not_to change(User, :count)
  expect(current_path).to eq('/users')
  expect(page).to have_content('Email must not be blank')
end

scenario 'I cannot sign up with an invalid email address' do
   expect { sign_up2(email: "invalid@email") }.not_to change(User, :count)
   expect(current_path).to eq('/users')
   expect(page).to have_content('Email has an invalid format')
 end
end

feature 'User sign in' do

  scenario 'with correct credentials' do
    sign_in
    expect(page).to have_content "Welcome, testemail@example.com"
  end

end

feature 'User signs out' do


  scenario 'while being signed in' do
    sign_in
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end
