# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to question' do
  given!(:user) { create(:user) }
  given!(:gist_url1) { 'https://www.google.ru' }
  given(:gist_url2) { 'https://www.google.ru' }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'User adds some links when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url1

    click_on 'add link'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url2

    click_on 'Create Question'

    expect(page).to have_link 'My gist', href: gist_url1
    expect(page).to have_link 'My gist', href: gist_url2
  end

  scenario 'User adds link when edit question', js: true do
    sign_in(user)
    visit questions_path

    click_on 'Edit question'
    click_on 'add link'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url1

    click_on 'Save'
    click_on question.title

    expect(page).to have_link 'My gist', href: gist_url1
  end
end
