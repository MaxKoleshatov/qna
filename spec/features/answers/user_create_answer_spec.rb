# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer question', %(
  to convey information
) do
  given!(:question) { create(:question) }

  describe 'Authenticated user' do
    
    given(:user) { create(:user) }

    scenario 'Authenticated user create answer' do
      sign_in(user)

      create_answer

      expect(page).to have_content 'Yes, you create new answer'
      expect(page).to have_content 'SomeText'
    end

    scenario 'Authenticated user creates response with errors' do
      sign_in(user)

      click_on 'All questions'
      click_on 'MyStringQuestion'
      click_on 'Create Answer'

      expect(page).to have_content "Text can't be blank"
    end
  end

  describe 'Unauthenticated user' do

    scenario 'Unauthenticated user creates response' do
      visit root_path
      create_answer

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page).not_to have_content 'SomeText'
    end
  end
end
