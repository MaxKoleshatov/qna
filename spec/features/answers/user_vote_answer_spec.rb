# frozen_string_literal: true

require 'rails_helper'

feature 'Юзер может проголосовать за ответ' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id) }
  given!(:counter1) { create(:counter_question, counterable_id: question.id, counterable_type: question.class) }
  given!(:counter2) { create(:counter_answer, counterable_id: answer.id, counterable_type: answer.class) }

  scenario 'Аутентифицированный пользователь может проголосовать за чужой ответ', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'UP'
    end

    expect(page).to have_content '1'
  end

  scenario 'Аутентифицированный пользователь может проголовать за или против 1 раз', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'DOWN'
      click_on 'UP'
    end

    expect(page).to have_content '-1'
  end

  scenario 'Аутентифицированный пользователь может отменить свой голос и проголосовать заново', js: true do
    sign_in(user1)
    visit question_path(question)

    within('.answers') do
      click_on 'UP'
      click_on 'DELETE_VOTE'
      click_on 'DOWN'
    end

    expect(page).to have_content '-1'
  end

  scenario 'Не ауинтефицированный пользователь не может проголосовать' do
    visit question_path(question)

    within('.answers') do
      expect(page).to_not have_content 'UP'
    end
  end
end
