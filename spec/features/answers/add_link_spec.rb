# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:gist_url1) { 'https://www.google.ru' }

  scenario 'User add link when create answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Text', with: 'SomeText'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url1

    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url1
    end
  end
end
