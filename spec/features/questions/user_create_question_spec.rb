# frozen_string_literal: true

require 'rails_helper'

feature 'The user can ask a question to find out something' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }

    scenario 'Authenticated user can create a question ' do
      sign_in(user)

      click_on 'Create new question'
      fill_in 'Title', with: 'Some Title'
      fill_in 'Body', with: 'Some body'
      click_on 'Create Question'

      expect(page).to have_content 'Yes, you create new question'
      expect(page).to have_content 'Some Title'
    end

    scenario 'Authenticated user wants to create a question but makes mistakes' do
      sign_in(user)

      click_on 'Create new question'

      click_on 'Create Question'

      expect(page).to have_content "Title can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Unauthenticated user wants to create a question' do
      visit root_path
      click_on 'Create new question'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
