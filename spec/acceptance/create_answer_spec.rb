require 'rails_helper'

feature 'Create answer', '
  Authenticated user able to add answer
' do

  given(:user) { create :user }
  given(:question) { create :question, user: user }

  scenario 'Authenticated user add answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'good answer!'
    click_on 'Add answer'
    within '.answers' do
      expect(page).to have_content 'good answer!'
    end
  end

  scenario 'Non-authenticated user add answer', js: true do
    visit question_path(question)
    expect(page).to_not have_content 'Add answer'
  end

   scenario 'invalid answer did not saves', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Add answer'
    expect(page).to have_content 'Body is too short (minimum is 5 characters)'
  end
end