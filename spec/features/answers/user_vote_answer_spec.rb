# frozen_string_literal: true

require 'rails_helper'

feature 'User can upvote the answer' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id) }

  scenario 'An authenticated user can upvote someone else answer', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'UP'
    end

    expect(page).to have_content '1'
  end

  scenario 'Authenticated user can vote for or against 1 time', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'DOWN'
      click_on 'UP'
    end

    expect(page).to have_content '-1'
  end

  scenario 'An authenticated user can cancel their vote and vote again', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'UP'
      click_on 'DELETE_VOTE'
      click_on 'DOWN'
    end

    expect(page).to have_content '-1'
  end

  # scenario 'Unauthenticated user cannot vote' do
  #   visit question_path(question)

  #   within('.answers') do
  #     expect(page).to_not have_content 'UP'
  #   end
  # end
end
