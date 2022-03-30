# frozen_string_literal: true

require 'rails_helper'

feature 'The user can edit their answers' do
  given!(:user) { create(:user) }
  given!(:user1) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthorized user cannot edit answers' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authorized user' do
    scenario 'can edit your answers', js: true do
      sign_in(user)

      visit question_path(question)

      click_on 'Edit answer'

      within '.answers' do
        fill_in 'Text', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.text
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'cant edit someone alien answer' do
      sign_in(user1)
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'can add attachments when editing your answer', js: true do
      sign_in(user)
      visit question_path(question)

      click_on 'Edit answer'

      within '.answers' do
        attach_file 'File',
                    ["#{Rails.root}/spec/features/images/image_1.rb", "#{Rails.root}/spec/features/images/image_2.rb"]
        click_on 'Save'
      end

      expect(page).to have_link 'image_1.rb'
      expect(page).to have_link 'image_2.rb'
    end

    scenario 'trying to add attachments when editing someone answer' do
      sign_in(user1)
      visit question_path(question)

      expect(page).to_not have_link 'Edit answer'
    end
  end
end
