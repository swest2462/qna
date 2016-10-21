require 'rails_helper'

feature 'Siging in', %q{
  user able to sign in
 } do

  given(:user) { create(:user) }
  scenario "Registred user sign in" do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345'
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end