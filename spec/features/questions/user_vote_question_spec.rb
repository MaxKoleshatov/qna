# frozen_string_literal: true

require 'rails_helper'

feature 'Юзер может проголосовать за вопрос' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:counter) { create(:counter_question, counterable_id: question.id, counterable_type: question.class) }

  scenario 'Аутентифицированный пользователь может проголосовать за чужой вопрос', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'UP'

    expect(page).to have_content '1'
  end

  scenario 'Аутентифицированный пользователь может проголовать за или против 1 раз', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'DOWN'
    click_on 'UP'

    expect(page).to have_content '-1'
  end

  scenario 'Аутентифицированный пользователь может отменить свой голос и проголосовать заново', js: true do
    sign_in(user1)
    visit question_path(question)

    click_on 'UP'
    click_on 'DELETE_VOTE'
    click_on 'DOWN'

    expect(page).to have_content '-1'
  end

  scenario 'Не ауинтефицированный пользователь не может проголовать' do
    visit question_path(question)

    expect(page).to_not have_content 'UP'
  end
end
