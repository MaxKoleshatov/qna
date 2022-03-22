# frozen_string_literal: true

require 'rails_helper'

feature 'The user can edit their answers' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthorized user cannot edit answers' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authorized user' do
    scenario 'can edit your answers', js: true do
      sign_in(user)

      visit question_path(question)

      click_on 'Edit answer'

      within '.answers' do
        fill_in 'Text', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.text
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'cant edit someone alien answer' do
      sign_in(user1)
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end
end
