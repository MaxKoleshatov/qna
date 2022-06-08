require 'rails_helper'

feature 'User can create the question multiplie' do
  given(:user) { create(:user) }

  context 'multiple session' do
    scenario 'questions appears on another user page', js: true do
      using_session('guest') do
      visit questions_path
      end

      using_session('user') do
        sign_in(user)
        visit root_path
      end

      using_session('user') do
        click_on 'Create new question'
        fill_in 'Title', with: 'Some Title'
        fill_in 'Body', with: 'Some body'
        click_on 'Create Question'

        expect(page).to have_content 'Some Title'
      end

      using_session('guest') do
        expect(page).to have_content 'Some Title'
      end
    end
  end
end