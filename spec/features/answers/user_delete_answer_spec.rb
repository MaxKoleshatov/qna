# frozen_string_literal: true

require 'rails_helper'

feature 'The user can delete their answers' do
  given(:user1) { create(:user) }
  given(:question) { create(:question, user: user1) }
  given!(:counter1) {create(:counter_question, counterable_id: question.id, counterable_type: question.class)}
  given!(:counter2) {create(:counter_answer, counterable_id: answer.id, counterable_type: answer.class)}

  describe 'Authenticated user' do
    given(:user2) { create(:user) }
    given!(:answer) { create(:answer, question: question, user: user1) }

    scenario 'Authenticated user wants to delete YOUR answer', js: true do
      sign_in(user1)

      visit question_path(question)
      click_on 'Delete answer'

      expect(page).not_to have_content answer.text
    end

    scenario 'Authenticated user wants to delete attachments from your answer', js: true do
      answer.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')
      answer.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_2.rb"), filename: 'image_2.rb')

      sign_in(user1)

      visit question_path(question)

      click_on 'Delete attachment image_1.rb'

      expect(page).not_to have_link 'image_1.rb'
      expect(page).to have_link 'image_2.rb'
    end

    scenario 'Authenticated user wants to delete someone ALIEN answer' do
      sign_in(user2)

      visit question_path(question)

      expect(page).not_to have_content 'Delete answer'
    end

    scenario 'Authenticated user wants to delete attachment from alien answer' do
      answer.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')

      sign_in(user2)

      visit question_path(question)

      expect(page).not_to have_link 'Delete attachment image_1.rb'
    end
  end

  describe 'Unauthenticated user' do
    given!(:answer) { create(:answer, question: question, user: user1) }

    scenario 'Unauthenticated user wants to delete ANY reply' do
      visit root_path

      visit question_path(question)

      expect(page).not_to have_content 'Delete answer'
    end

    scenario 'Unauthenticated user wants to delete attachment from answer' do
      answer.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')

      visit root_path

      visit question_path(question)

      expect(page).not_to have_content 'Delete attachment image_1.rb'
    end
  end
end
