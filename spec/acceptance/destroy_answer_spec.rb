
require 'rails_helper'

feature 'User able to delete his answer', '
' do

  given(:user) { create :user }
  given(:another_user) { create :user }
  given(:question) { create :question, user: user }
  given!(:answer) { create :answer, question: question, user: user }

  scenario 'Owner try to delete answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content 'Answer body'
    click_on 'Delete answer'
    expect(page).to_not have_content 'Answer body'
  end

  scenario 'Not owner try to delete answer' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to have_content 'Good question body'
    expect(page).to_not have_content 'Delete question'
  end
end