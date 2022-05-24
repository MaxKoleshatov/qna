# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete links' do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:link) { create(:link, linkable: question, url: 'https://www.google.ru') }
  given!(:counter) {create(:counter_question, counterable_id: question.id, counterable_type: question.class)}

  scenario 'Authorized user can delete link if he author link', js: true do
    sign_in(user)
    visit question_path(question)

    within('.links') do
      click_on 'Delete link'
    end

    expect(page).to_not have_link link.name, href: 'https://www.google.ru'
  end

  scenario 'Authorized user cant delete link if he dont author link' do
    sign_in(user2)
    visit question_path(question)

    within('.links') do
      expect(page).to_not have_link 'Delete link'
    end
  end
end
