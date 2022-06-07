require 'rails_helper'

feature 'User can answer the question multiplie' do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }

  context 'multiple session' do
    scenario 'answer appears on another user page', js: true do
      
      using_session('user2') do
      sign_in(user2)
      visit question_path(question)
      end

      using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      using_session('user') do
        fill_in 'Text', with: 'SomeText'
        click_on 'Create Answer'

        expect(page).to have_content 'SomeText'
      end

      using_session('user2') do
        expect(page).to have_content 'SomeText'
      end
    end
  end
end