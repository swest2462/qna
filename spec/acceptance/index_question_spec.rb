
require 'rails_helper'

feature 'Questions index', '
  non-authenticated user
  able to see questions list
' do

  given!(:question) { create_pair :question }

  scenario 'Non-authenticated user visit qustions#index' do
    visit questions_path
    expect(page).to have_css('.question_title', count: 2)
  end
end