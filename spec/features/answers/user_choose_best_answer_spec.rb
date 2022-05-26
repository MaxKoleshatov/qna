# frozen_string_literal: true

require 'rails_helper'

feature 'The user can choose the best answer' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  given!(:answer1) { create(:answer, question_id: question.id, user_id: user1.id) }

  describe 'Unauthorized user' do
    scenario 'Unauthorized user cannot choose the best answer' do
      visit questions_path

      click_on question.title.to_s

      expect(page).to_not have_content 'Make Best'
    end
  end

  describe 'Authorized user' do
    scenario 'authorized user cannot choose the best answer if he is not the author of the question' do
      sign_in(user1)

      visit questions_path

      click_on question.title.to_s

      expect(page).to_not have_content 'Make Best'
    end

    scenario 'authorized user can choose the best answer if he is author of the question' do
      sign_in(user)

      visit questions_path

      click_on question.title.to_s

      expect(page).to have_content 'Make Best'
    end

    scenario 'authorized user chooses the best answer and he becomes the best', js: true do
      sign_in(user)

      visit questions_path

      click_on question.title.to_s

      within(".answer-#{answer.id}") do
        click_on 'Make Best'
        expect(page).to have_content 'This best answer'
      end
    end

    scenario 'authorized user chooses the best answer and it becomes the first in the list', js: true do
      sign_in(user)

      visit questions_path

      click_on question.title.to_s

      within(".answer-#{answer1.id}") do
        click_on 'Make Best'
      end

      second = find(".answer-#{answer1.id}")

      expect(second).to have_sibling(".answer-#{answer.id}", below: second)
    end
  end
end
