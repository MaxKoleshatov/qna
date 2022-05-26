# frozen_string_literal: true

require 'rails_helper'

feature 'User can vote for a question' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'An authenticated user can upvote someone else question', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'UP'

    expect(page).to have_content '1'
  end

  scenario 'Authenticated user can vote for or against 1 time', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'DOWN'
    click_on 'UP'

    expect(page).to have_content '-1'
  end

  scenario 'An authenticated user can cancel their vote and vote again', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'UP'
    click_on 'DELETE_VOTE'
    click_on 'DOWN'

    expect(page).to have_content '-1'
  end

  scenario 'A non-authenticated user cannot vote' do
    visit question_path(question)

    expect(page).to_not have_content 'UP'
  end
end
