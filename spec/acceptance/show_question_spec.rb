require 'rails_helper'

feature 'Question show', '
  non-authenticated user
  able to see question content' do

  given!(:user) { create :user }
  given!(:question) { create :question, user: user }


  scenario 'Non-authenticated user can see content' do
    visit questions_path
    click_on 'show'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end
end