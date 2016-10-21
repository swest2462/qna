require 'rails_helper'

feature 'Create answer', '
  Authenticated user able to add answer
' do

  given(:user) { create :user }
  given(:question) { create :question, user: user }

  scenario 'Authenticated user add answer' do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'good answer!'
    click_on 'Add answer'
    expect(page).to have_content 'good answer!'
    expect(page).to have_content 'Your answer successfully saved'
  end

  scenario 'Non-authenticated user add answer' do
    visit question_path(question)
    expect(page).to_not have_content 'Add answer'
  end

   scenario 'invalid answer did not saves' do
    sign_in(user)
    visit question_path(question)
    click_on 'Add answer'
    expect(page).to have_content 'Answer not saved'
  end

end