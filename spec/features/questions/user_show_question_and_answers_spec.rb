# frozen_string_literal: true

require 'rails_helper'

feature 'User can see question and for answers' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'User can see question and for answers' do
    visit question_path(question)

    expect(page).to have_content answer.text
  end
end
