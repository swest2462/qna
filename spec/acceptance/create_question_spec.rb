require 'rails_helper'

feature 'Create question', %q{
  authenticated user able to ask the question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user create the question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user try to create question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'invalid question did not saved' do
    sign_in(user)
    visit new_question_path

    fill_in 'question_title', with: 'Title'
    click_on 'Create'
    expect(page).to have_content 'Question not saved.'
    visit questions_path
    expect(page).to_not have_content 'Title'
  end
end