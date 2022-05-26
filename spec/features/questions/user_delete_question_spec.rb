# frozen_string_literal: true

require 'rails_helper'

feature 'The user can delete the question' do
  given(:user1) { create(:user) }
  given(:question) { create(:question, user: user1) }

  describe 'Authenticated user' do
    given(:user2) { create(:user) }

    scenario 'Authenticated user can delete your question' do
      sign_in(user1)
      visit question_path(question)

      click_on 'Delete question'

      expect(page).not_to have_content question.title
      expect(page).to have_content 'Yes, you delete question'
    end

    scenario 'Authenticated user can delete any attachment from your question', js: true do
      question.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')
      question.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_2.rb"), filename: 'image_2.rb')

      sign_in(user1)
      visit question_path(question)

      click_on 'Delete attachment image_1.rb'

      expect(page).not_to have_link 'image_1.rb'
      expect(page).to have_link 'image_2.rb'
    end

    scenario 'Authenticated user cant delete alien question' do
      sign_in(user2)

      visit question_path(question)

      expect(page).not_to have_content 'Delete question'
    end

    scenario 'Authenticated user cant delete attachment from alien question' do
      question.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')

      sign_in(user2)

      visit question_path(question)

      expect(page).not_to have_link 'Delete attachment image_1.rb'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Unauthenticated user cant delete someone question' do
      visit root_path

      visit question_path(question)

      expect(page).not_to have_content 'Delete question'
    end

    scenario 'Unauthenticated user cant delete attachment from alien question' do
      question.files.attach(io: File.open("#{Rails.root}/spec/features/images/image_1.rb"), filename: 'image_1.rb')

      visit root_path

      visit question_path(question)

      expect(page).not_to have_link 'Delete attachment image_1.rb'
    end
  end
end
