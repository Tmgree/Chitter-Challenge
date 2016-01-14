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
    fill_in 'peeping', with: 'testing123'
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
end
