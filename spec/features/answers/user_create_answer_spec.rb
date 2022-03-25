# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer question', %(
  to convey information
) do
  given!(:question) { create(:question) }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    scenario 'Authenticated user create answer', js: true do
      sign_in(user)

      visit question_path(question)

      fill_in 'Text', with: 'SomeText'
      click_on 'Create Answer'

      within '.answers' do
        expect(page).to have_content 'SomeText'
      end
    end

    scenario 'Authenticated user creates response with errors', js: true do
      sign_in(user)

      visit question_path(question)
      click_on 'Create Answer'

      expect(page).to have_content "Text can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Unauthenticated user creates response' do
      visit root_path

      click_on 'All questions'
      click_on 'MyStringQuestion'
      fill_in 'Text', with: 'SomeText'
      click_on 'Create Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page).not_to have_content 'SomeText'
    end
  end
end
