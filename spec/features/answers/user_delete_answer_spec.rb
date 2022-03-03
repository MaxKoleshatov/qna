# frozen_string_literal: true

require 'rails_helper'

feature 'The user can delete their answers' do

  given(:user1) { create(:user) }
  given(:question) { create(:question, user: user1) }
  given(:answer) { create(:answer, question: question, user: user1) }

  describe 'Authenticated user' do

    given(:user2) { create(:user) }

    scenario 'Authenticated user wants to delete YOUR answer' do
      sign_in(user1)

      visit answer_path(answer)
      click_on 'Delete answer'

      expect(page).not_to have_content answer.text.to_s
      expect(page).to have_content 'Yes, you delete answer'
    end

    scenario 'Authenticated user wants to delete someone ALIEN answer' do
      sign_in(user2)

      visit answer_path(answer)

      expect(page).not_to have_content 'Delete answer'
    end
  end

  describe 'Unauthenticated user' do

    scenario 'Unauthenticated user wants to delete ANY reply' do
      visit root_path

      visit answer_path(answer)

      expect(page).not_to have_content 'Delete'
    end
  end
end
