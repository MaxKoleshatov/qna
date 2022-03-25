# frozen_string_literal: true

require 'rails_helper'

feature 'The user can edit their questions' do
  given!(:question) { create(:question, user_id: user.id) }
  given(:user) { create(:user) }
  given(:user1) { create(:user) }

  scenario 'Unauthorized user cannot edit questions' do
    visit questions_path

    expect(page).to_not have_content 'Edit question'
  end

  scenario 'authorized user can edit their questions', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Edit question'

    fill_in 'Body', with: 'edited body question'
    click_on 'Save'

    expect(page).to_not have_content question.body
    expect(page).to have_content 'edited body question'
    expect(page).to_not have_selector 'textarea'
  end

  scenario 'authorized user cannot edit alien questions' do
    sign_in(user1)

    visit questions_path

    expect(page).to_not have_content 'Edit question'
  end
end
