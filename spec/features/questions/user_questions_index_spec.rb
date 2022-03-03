# frozen_string_literal: true

require 'rails_helper'

feature 'User can see all questions' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'User can see all questions' do
    visit root_path
    click_on 'All questions'

    expect(current_path).to eql(questions_path)
    expect(page).to have_content question.body.to_s
  end
end
