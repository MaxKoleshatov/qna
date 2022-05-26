# frozen_string_literal: true

require 'rails_helper'

feature 'User can create prize to question' do
  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user2.id) }
  given!(:prize) { create(:prize, question_id: question.id) }
  given!(:prize1) { create(:prize, question_id: question.id, user_id: user2.id) }

  scenario 'User create prize when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Prize name', with: 'Whale'
    attach_file 'Image', "#{Rails.root}/spec/features/images/image_4.jpg"

    click_on 'Create Question'

    within '.prizes' do
      expect(page).to have_content 'Whale'
    end
  end

  scenario ' The user can award a prize by choosing the best answer', js: true do
    sign_in(user)

    visit question_path(question)

    within(".answer-#{answer.id}") do
      click_on 'Make Best'
    end

    visit prizes_path

    expect(page).to_not have_content 'PrizeName'
    expect(user2.id).to eq question.prize.user_id
  end

  scenario 'User can view their prizes' do
    sign_in(user2)

    visit prizes_path

    expect(page).to have_content prize1.name
  end

  scenario 'Unauthenticated user cannot view prizes' do
    visit root_path

    expect(page).to_not have_content 'All prizes'
  end
end
